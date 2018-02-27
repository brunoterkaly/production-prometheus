#####################################
# Deploy Prometheus
kubectl create namespace prometheus
kubectl create secret tls prometheus-server-tls --key /home/azureuser/mycerts/tls.key --cert /home/azureuser/mycerts/tls.crt --namespace prometheus
cd /datadrive/helm/project-prometheus/prometheus
helm install -f values.yaml stable/prometheus --name prometheus --namespace prometheus

#####################################
# Deploy Grafana
cd /datadrive/helm/project-prometheus/grafana
kubectl create namespace grafana
kubectl create secret tls grafana-server-tls --key /home/azureuser/mycerts/tls.key --cert /home/azureuser/mycerts/tls.crt --namespace grafana
helm install -f values.yaml stable/grafana --name grafana --namespace grafana

#####################################
# Deploy Ingress Controllers
cd /datadrive/helm/project-prometheus
kubectl create -f nginx-ingress-grafana-rc.yaml --namespace grafana
kubectl expose rc nginx-ingress-grafana-rc --port="80,443" --type="LoadBalancer" --namespace grafana
# Deploy prometheus
kubectl create -f nginx-ingress-prom-rc.yaml --namespace prometheus
kubectl create -f nginx-ingress-prom-svc.yaml --namespace prometheus
#############################################
# dry run lets you see the rendered yaml
#helm install --debug --dry-run -f values.yaml stable/prometheus --name prometheus --namespace prometheus > rendered.yaml
