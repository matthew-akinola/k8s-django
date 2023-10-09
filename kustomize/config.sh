#!/bin/bash

# Define the cluster name
CLUSTER_NAME="k8s-cluster"

# Create a Kind cluster
kind create cluster --name $CLUSTER_NAME --config cluster-config.yaml

#validate if cluster is up
kubectl cluster-info --context kind-$CLUSTER_NAME

# Set the kubeconfig context to the Kind cluster
kubectl config use-context kind-$CLUSTER_NAME

#Install the manifests
kubectl apply -k base/.

# # Install Metrics Server for Kubernetes API metrics
# kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# # Wait for Metrics Server to be ready
# kubectl wait --namespace kube-system \
#   --for=condition=ready pod \
#   --selector=k8s-app=metrics-server \
#   --timeout=90s

# Add the Prometheus Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

#create prometheus namespace
kubectl create namespace prometheus

# Install Prometheus using Helm
helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"

# Wait for Prometheus to be ready
kubectl wait --namespace default \
  --for=condition=ready pod \
  --selector=app=prometheus-server \
  --timeout=90s

# Add the Grafana Helm repository
helm repo add grafana https://grafana.github.io/helm-charts

#create grafana namespace
kubectl create namespace grafana

# Install Grafana using Helm
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --values grafana.yaml \
    --set service.type=LoadBalancer

# Wait for Grafana to be ready
kubectl wait --namespace default \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=grafana \
  --timeout=90s

# Get the Grafana admin password
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Print instructions to port-forward Grafana to access the dashboard
echo "To access Grafana, run the following command:"
kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090:9090
kubectl port-forward --namespace default svc/grafana 3000:3000

