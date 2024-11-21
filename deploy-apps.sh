#!/bin/bash -x


export INGRESS_IP=$(kubectl get svc -A | grep nginx | grep NodePort | tr -s ' ' | cut -d' ' -f4)
echo "INGRESS_IP is: ${INGRESS_IP}"


# 1. Authentication
# ================================================================================================
# ================================================================================================
kubectl apply -f auth/auth-namespace.yaml

# First build the keycloak database docker image with database auto-init scripts
docker build --tag localhost:32770/keycloak-postgresdb:1.0 auth/keycloak-postgresdb
docker push localhost:32770/keycloak-postgresdb:1.0

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
cat auth/oauth-proxy/oauth-proxy-deployment.yaml | envsubst | kubectl apply -f -
kubectl apply -f auth/oauth-proxy/oauth-proxy-ingress.yaml
sleep 1
kubectl wait --namespace auth \
  --for=condition=ready pod \
  --selector=app=oauth-proxy \
  --timeout=90s


# 2. Tracing
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


# 3. Logging
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


# 4. Monitoring
# ================================================================================================
# ================================================================================================
kubectl apply -f monitoring/monitoring-namespace.yaml

# Start metrics-server (for `kubectl top <pods/nodes>` metrics)
kubectl apply -f monitoring/metrics-server/metrics-server-deployment.yaml

# Start node-exporter (for prometheus)
kubectl apply -f monitoring/node-exporter/node-exporter-daemonset.yaml

# Start prometheus (for grafana)
kubectl apply -f monitoring/prometheus/prometheus-service-account.yaml
kubectl apply -f monitoring/prometheus/prometheus-cluster-role.yaml
kubectl apply -f monitoring/prometheus/prometheus-cluster-role-binding.yaml
kubectl apply -f monitoring/prometheus/prometheus-configmap.yaml
kubectl apply -f monitoring/prometheus/prometheus-deployment.yaml
kubectl apply -f monitoring/prometheus/prometheus-ingress.yaml
sleep 1
kubectl wait --namespace monitoring \
  --for=condition=ready pod \
  --selector=app=prometheus \
  --timeout=90s

# Start grafana
docker build --tag localhost:32770/grafana-init-container:1.0 monitoring/grafana
docker push localhost:32770/grafana-init-container:1.0

kubectl apply -f monitoring/grafana/grafana-configmap.yaml
kubectl apply -f monitoring/grafana/grafana-deployment.yaml
kubectl apply -f monitoring/grafana/grafana-ingress.yaml
sleep 1
kubectl wait --namespace monitoring \
  --for=condition=ready pod \
  --selector=app=grafana \
  --timeout=90s


# 5. Deploy chat-app
# ================================================================================================
# ================================================================================================
kubectl apply -f chat-app/chat-app-postgresdb-deployment.yaml

docker build --tag localhost:32770/chat-app:1.0 chat-app
docker push localhost:32770/chat-app:1.0

kubectl apply -f chat-app/chat-app-deployment.yaml
kubectl apply -f chat-app/chat-app-ingress.yaml
