# Rental Recommender

## Deploy script:
```
./deploy-local.sh
```

TODO: chat-app still not yet deployable in `kind` due to nvidia GPU requirement and k8s pain to configure GPU support.
But you can run it manually using `docker run` (see README in chat-app/ dir).

Manual instructions below shouldn't be needed..

---

## Old Setup Instructions

1. Create kind cluster with nginx ingress support
```
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
```

2. Install nginx ingress
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# (Optional) Wait for nginx ingress to be ready:
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s
```

3. Local development only:

Manually add this entry to bottom of /etc/hosts file.
```
127.0.0.1 houseproject.internal
```

Fixup the HostAliases ip for the nginx ingress controller.
```
kubectl get svc -A

# E.g.
ingress-nginx   ingress-nginx-controller             NodePort    10.96.93.100   <none>        80:30119/TCP,443:32280/TCP   45m

# Grab the ip address of ingress-nginx-controller (NodePort): 10.96.93.100 in this case.
# Manually update oauth-proxy/oauth-proxy-pod.yaml and myapp/myapp-pod.yaml with this ip address.

# This shouldn't be necessary once everything is deployed in cloud because we will have an actual real DNS.
# It is a problem locally because the DNS is routed to `localhost` which is not the nginx-ingress-controller.

# Example of the change needed:
diff --git myapp/myapp-pod.yaml myapp/myapp-pod.yaml
index edca0c5..1efb965 100644
--- myapp/myapp-pod.yaml
+++ myapp/myapp-pod.yaml
@@ -6,7 +6,7 @@ metadata:
   name: myapp
 spec:
   hostAliases:
-  - ip: "10.96.173.176"
+  - ip: "10.96.93.100"
     hostnames:
       - "houseproject.internal"
   containers:
diff --git oauth-proxy/oauth-proxy-pod.yaml oauth-proxy/oauth-proxy-pod.yaml
index 3d7f567..5f4c09d 100644
--- oauth-proxy/oauth-proxy-pod.yaml
+++ oauth-proxy/oauth-proxy-pod.yaml
@@ -6,7 +6,7 @@ metadata:
   name: oauth-proxy
 spec:
   hostAliases:
-  - ip: "10.96.173.176"
+  - ip: "10.96.93.100"
     hostnames:
       - "houseproject.internal"
   volumes:
```


4. Build custom docker images and load them into kind cluster
```
# NOTE: we cannot use `:latest` tag because kubernetes will always try to pull it from public dockerhub,
# and these don't exist there
docker build --tag keycloak-postgres:1.0 keycloak-postgres
docker build --tag myapp:1.0 myapp

kind load docker-image keycloak-postgres:1.0
kind load docker-image myapp:1.0
```

5. Start keycloak-postgres db & keycloak application
```
kubectl apply -f keycloak-postgres/postgres-pod.yaml
kubectl apply -f keycloak-postgres/postgres-service.yaml

# NOTE: Before starting keycloak application, wait 20 seconds or check that postgresdb is initialized: `kubectl logs keycloak-postgres`
kubectl apply -f keycloak/keycloak-pod.yaml
kubectl apply -f keycloak/keycloak-service.yaml
kubectl apply -f keycloak/keycloak-ingress.yaml

# Confirm that keycloak application came up without database connection errors: `kubectl logs keycloak`
# Keycloak can take 60s to initialize
```

6. Start oauth-proxy
```
kubectl apply -f oauth-proxy/oauth-proxy-configmap.yaml
kubectl apply -f oauth-proxy/oauth-proxy-pod.yaml
kubectl apply -f oauth-proxy/oauth-proxy-service.yaml
kubectl apply -f oauth-proxy/oauth-proxy-ingress.yaml

# Confirm that oauth-proxy initializes correctly. It tries to authenticate with keycloak on the 'well-known' endpoint.
# You should see something like `OAuthProxy configured for Keycloak OIDC Client ID: oauth-proxy-client` inside `kubectl logs oauth-proxy`
```

7. Start jaeger
```
kubectl apply -f jaeger/jaeger-deployment.yaml
kubectl apply -f jaeger/jaeger-service.yaml
kubectl apply -f jaeger/jaeger-ingress.yaml

# Confirm that http://.../jaeger works
```

8. Start myapp
```
kubectl apply -f myapp/myapp-pod.yaml
kubectl apply -f myapp/myapp-service.yaml
kubectl apply -f myapp/myapp-ingress.yaml

# This app is protected by keycloak authentication (see the ingress annotations).
# Going to http://houseproject.internal/myapp should redirect you automatically to keycloak to sign-in/register.
# Once signed-in you should be redirected back to myapp.

# NOTE: There is a user with credentials (username: foo, password: bar), but do confirm that the sign-up flow works.
```

9. Start elasticsearch
```
kubectl apply -f elasticsearch/elasticsearch-configmap.yaml
kubectl apply -f elasticsearch/elasticsearch-deployment.yaml
```

10. Start fluent-bit
```
kubectl apply -f fluent-bit/fluent-bit-configmap.yaml
kubectl apply -f fluent-bit/fluent-bit-daemonset.yaml
```
