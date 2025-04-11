#!/bin/bash

echo "🔥 Suppression complète de tous les objets Kubernetes (pods, services, deployments, ingress)..."


kubectl delete all --all


kubectl delete ingress --all

kubectl delete configmap --all
kubectl delete secret --all

kubectl delete pvc --all
kubectl delete pv --all

echo "🧹 Tout a été supprimé."

echo ""
echo "📦 État actuel du cluster (doit être vide sauf 'kubernetes') :"
kubectl get all
kubectl get ingress

echo ""
echo "✅ Cluster propre. Tu peux maintenant redeployer avec :"
echo "kubectl apply -f ./infra/k8s/ ou ./build-and-deploy.sh"
