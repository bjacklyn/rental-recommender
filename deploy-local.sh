#!/bin/bash -x

# 1. Install the kubernetes control plane with `kind`
# ================================================================================================
# ================================================================================================
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
  extraMounts:
  - hostPath: /var/log/pods
    containerPath: /var/log/pods
    readOnly: false
    selinuxRelabel: false
    propagation: Bidirectional
EOF


# 2. Nginx ingress
# ================================================================================================
# ================================================================================================
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Wait for nginx ingress to be ready:
sleep 1
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s


# 3. Authentication
# ================================================================================================
# ================================================================================================
kubectl apply -f auth/auth-namespace.yaml

# First build the keycloak database docker image with database auto-init scripts
docker build --tag keycloak-postgresdb:1.0 auth/keycloak-postgresdb
kind load docker-image keycloak-postgresdb:1.0

# Start the keycloak database
kubectl apply -f auth/keycloak-postgresdb/keycloak-postgresdb-deployment.yaml
sleep 1
kubectl wait --namespace auth \
  --for=condition=ready pod \
  --selector=app=keycloak-postgresdb \
  --timeout=30s

# Start the keycloak application
kubectl apply -f auth/keycloak/keycloak-deployment.yaml
kubectl apply -f auth/keycloak/keycloak-ingress.yaml
sleep 1
kubectl wait --namespace auth \
  --for=condition=ready pod \
  --selector=app=keycloak \
  --timeout=90s

# Start the oauth-proxy
kubectl apply -f auth/oauth-proxy/oauth-proxy-configmap.yaml
kubectl apply -f auth/oauth-proxy/oauth-proxy-deployment.yaml
kubectl apply -f auth/oauth-proxy/oauth-proxy-ingress.yaml
sleep 1
kubectl wait --namespace auth \
  --for=condition=ready pod \
  --selector=app=oauth-proxy \
  --timeout=90s


# 4. Tracing
# ================================================================================================
# ================================================================================================
kubectl apply -f tracing/tracing-namespace.yaml
kubectl apply -f tracing/jaeger/jaeger-deployment.yaml
kubectl apply -f tracing/jaeger/jaeger-ingress.yaml
sleep 1
kubectl wait --namespace tracing \
  --for=condition=ready pod \
  --selector=app=jaeger \
  --timeout=90s


# 5. Logging
# ================================================================================================
# ================================================================================================
kubectl apply -f logging/logging-namespace.yaml

# Start elasticsearch (for fluent-bit & kibana)
kubectl apply -f logging/elasticsearch/elasticsearch-configmap.yaml
kubectl apply -f logging/elasticsearch/elasticsearch-deployment.yaml
sleep 1
kubectl wait --namespace logging \
  --for=condition=ready pod \
  --selector=app=elasticsearch \
  --timeout=90s

# Start fluent-bit
kubectl apply -f logging/fluent-bit/fluent-bit-configmap.yaml
kubectl apply -f logging/fluent-bit/fluent-bit-daemonset.yaml

# Start kibana
kubectl apply -f logging/kibana/kibana-configmap.yaml
kubectl apply -f logging/kibana/kibana-deployment.yaml
kubectl apply -f logging/kibana/kibana-ingress.yaml
sleep 1
kubectl wait --namespace logging \
  --for=condition=ready pod \
  --selector=app=kibana \
  --timeout=90s


# 6. Monitoring
# ================================================================================================
# ================================================================================================
kubectl apply -f monitoring/monitoring-namespace.yaml

# Start metrics-server (for `kubectl top <pods/nodes>` metrics)
kubectl apply -f monitoring/metrics-server/metrics-server-deployment.yaml

# Start node-exporter (for prometheus)
kubectl apply -f monitoring/node-exporter/node-exporter-daemonset.yaml

# Start prometheus (for grafana)
kubectl apply -f monitoring/prometheus/prometheus-configmap.yaml
kubectl apply -f monitoring/prometheus/prometheus-deployment.yaml
kubectl apply -f monitoring/prometheus/prometheus-ingress.yaml
sleep 1
kubectl wait --namespace monitoring \
  --for=condition=ready pod \
  --selector=app=prometheus \
  --timeout=90s

# Start grafana
kubectl apply -f monitoring/grafana/grafana-configmap.yaml
kubectl apply -f monitoring/grafana/grafana-deployment.yaml
kubectl apply -f monitoring/grafana/grafana-ingress.yaml
sleep 1
kubectl wait --namespace monitoring \
  --for=condition=ready pod \
  --selector=app=grafana \
  --timeout=90s
