#!/bin/bash -x

# 1. Install the kubernetes control plane with `minikube` and enable GPU support
# ================================================================================================
# ================================================================================================
minikube start --driver docker --container-runtime docker --cpus 2 --memory 6000


docker run -d -p 32770:5000 --name local-registry registry:2

# 2. Nginx ingress
# ================================================================================================
# ================================================================================================
minikube addons enable ingress
minikube addons enable registry


# Wait for nginx ingress to be ready:
sleep 1
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

sudo cp misc/minikube-tunnel.service /etc/systemd/system/minikube-tunnel.service
sudo cp misc/kubectl-port-forward.service /etc/systemd/system/kubectl-port-forward.service

sudo setcap 'cap_net_bind_service=+ep' $(which kubectl)
getcap $(which kubectl)

sudo systemctl daemon-reload
sudo systemctl enable minikube-tunnel
sudo systemctl start minikube-tunnel

sudo systemctl enable kubectl-port-forward
sudo systemctl start kubectl-port-forward