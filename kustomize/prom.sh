Steps to Install Prometheus:
--------------------------------

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -n prometheus
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext
#To get the service spec type and spec port
# kubectl get svc prometheus-server-ext -o jsonpath='{.spec.type}'
# kubectl get svc prometheus-server-ext -o jsonpath='{.spec.ports[0].nodePort}'

#to get the nodes internal ip addr
# kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'

# Steps to install Grafana:
--------------------------

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana stable/grafana
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext
kind service grafana-ext

# To get user name and password in Grafana:

kubectl get secret --namespace default grafana -o yaml
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# echo "RkpwY21aTFNXRDVJN3Z4RWFFUjlibkV1SDBDbnFBendadmc0bmROZQ==" | openssl base64 -d ; echo

----------------------------------------------------------

# Dashboards: https://grafana.com/grafana/dashboards/6417
# Grafana playlist: https://www.youtube.com/playlist?list=PLVx1qovxj-akOGKSoQ5sGc5ZRfH8Tpnow
# Prometheus Playlist: https://www.youtube.com/playlist?list=PLVx1qovxj-anCTn6um3BDsoHnIr0O2tz3