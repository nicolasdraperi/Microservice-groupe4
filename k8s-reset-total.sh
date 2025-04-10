#!/bin/bash

echo "🔥 Suppression complète de tous les objets Kubernetes (pods, services, deployments, ingress)..."

# Supprime tout : pods, services, deployments, replicasets, etc.
kubectl delete all --all

# Supprime tous les ingress (non inclus dans 'all')
kubectl delete ingress --all

# Supprime les configmaps et secrets si besoin
kubectl delete configmap --all
kubectl delete secret --all

# Supprime les persistent volumes (si utilisés un jour)
kubectl delete pvc --all
kubectl delete pv --all

echo "🧹 Tout a été supprimé."

echo ""
echo "📦 État actuel du cluster (doit être vide sauf 'kubernetes') :"
kubectl get all
kubectl get ingress

echo ""
echo "✅ Cluster propre. Tu peux maintenant redeployer avec :"
echo "kubectl apply -f ./infra/k8s/"
