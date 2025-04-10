#!/bin/bash

echo "🔧 [1/3] Build des images Docker pour chaque service..."

docker build -t client ./client
docker build -t posts ./posts
docker build -t comments ./comments
docker build -t query ./query
docker build -t moderation ./moderation
docker build -t event-bus ./event-bus

echo "✅ Images Docker buildées."

echo ""
echo "🚀 [2/3] Déploiement sur Kubernetes..."

kubectl apply -f ./infra/k8s/

echo ""
echo "📦 [3/3] État du cluster après déploiement :"
kubectl get pods
kubectl get svc
kubectl get ingress

echo ""
echo "🌍 Ouvre maintenant : http://posts.com"
