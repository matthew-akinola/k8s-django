kind create cluster --name k8s-cluster --config cluster-config.yaml
kubectl cluster-info --context kind-k8s-cluster

kind delete cluster --name k8s-cluster