#!/bin/bash -x

# 1. Install the kubernetes control plane with `minikube` and enable GPU support
# ================================================================================================
# ================================================================================================
minikube start --driver docker --container-runtime docker --gpus all --cpus 10 --memory 16392


# 2. Nginx ingress
# ================================================================================================
# ================================================================================================
minikube addons enable ingress

# Wait for nginx ingress to be ready:
sleep 1
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s


# 3. Deploy all kubernetes apps
# ================================================================================================
# ================================================================================================
#source deploy-apps.sh


# 4. Tell user to setup tunneling
# ================================================================================================
# ================================================================================================
set +x
echo ""
echo "================================================================================================"
echo "You must run 'minikube tunnel' for the k8s services to be available at http://localhost/<svc>!"
echo "================================================================================================"
