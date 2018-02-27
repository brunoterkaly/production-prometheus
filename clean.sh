helm del --purge prometheus
helm del --purge grafana
kubectl delete rc nginx-ingress-grafana-rc -n grafana
kubectl delete rc nginx-ingress-prom-rc -n prometheus
kubectl delete --all pods
kubectl delete svc nginx-ingress-grafana-rc -n grafana
kubectl delete svc nginx-ingress-prom-rc -n prometheus
kubectl delete secret prometheus-server-tls -n grafana
kubectl delete secret grafana-server-tls -n grafana
kubectl delete ns prometheus
kubectl delete ns grafana
