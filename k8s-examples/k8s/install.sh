BASEDIR=$(dirname "$0")

kubectl create ns kafka
kubectl label namespace kafka istio-injection=enabled --overwrite=true
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-release --set persistence.enabled=false --set zookeeper.persistence.enabled=false bitnami/kafka -f values.yaml -n kafka
kubectl apply -f $BASEDIR/kafka-sample.yaml -n kafka
kubectl apply -f $BASEDIR/../istio/istio-peer-authentication.yaml -n kafka

