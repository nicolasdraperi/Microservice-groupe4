
# Projet fil rouge — Microservices avec Kubernetes

## Présentation

Ce projet est une application en microservices développée avec **Node.js** et **React**, déployée dans un environnement **Kubernetes**.  
Il a été réalisé dans le cadre du **Master Dev IA — Groupe 6** par
 - Nicolas Draperi
 - Hugo KHALED BROTONS
 - Nail BENAMER
 - Meissa MARA
 - Jules CAPEL
 - Deep KALYAN
 

## Table des matières

- [Présentation](#présentation)
- [Architecture](#architecture)
- [Chemins d'Ingress](#chemins-dingress)
- [Noms de Services Kubernetes](#noms-de-services-kubernetes)
- [Ports des Services](#ports-des-services)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Déploiement](#déploiement)
- [Accès à l'application](#accès-à-lapplication)
- [Installation du NGINX Ingress Controller](#installation-du-nginx-ingress-controller)
- [Lancement des scripts](#lancement-des-scripts)
- [Utilisation de `curl`](#utilisation-de-curl)

## Architecture

L'application est composée des services suivants :

- **Client** : Interface utilisateur (React)
- **Posts** : Création de posts
- **Comments** : Ajout de commentaires
- **Query** : Regroupement des données
- **Moderation** : Modération automatique
- **Event Bus** : Système de communication entre services

## Prérequis

- Node.js
- Docker
- Kubernetes (via Docker Desktop ou Minikube)
- NGINX Ingress Controller


## Chemins d'Ingress

| Chemin                                | Service Kubernetes       | Port |
|--------------------------------------|--------------------------|------|
| `/posts/create`                      | `posts-clusterip-srv`    | 4000 |
| `/posts`                             | `query-srv`              | 4002 |
| `/posts/?(.*)/comments`              | `comments-srv`           | 4001 |
| `/?(.*)` (interface utilisateur)     | `client-srv`             | 3000 |

## Noms de Services Kubernetes

| Nom du service Kubernetes | Rôle |
|---------------------------|------|
| `client-srv`              | Interface utilisateur React |
| `posts-clusterip-srv`     | API de création de posts |
| `query-srv`               | Service d'agrégation |
| `comments-srv`            | Gestion des commentaires |
| `moderation-srv`          | Filtrage de contenu |
| `event-bus-srv`           | Transmission d'événements |

## Ports des Services

| Service                | Port |
|------------------------|------|
| `client-srv`           | 3000 |
| `posts-clusterip-srv`  | 4000 |
| `query-srv`            | 4002 |
| `comments-srv`         | 4001 |
| `moderation-srv`       | 4003 |
| `event-bus-srv`        | 4005 |

## Installation

1. Cloner le dépôt :

```bash
git clone https://github.com/nicolasdraperi/Microservice-groupe6.git
cd Microservice-groupe6
```

2. Installer les dépendances pour chaque service :

```bash
cd client && npm install
cd ../posts && npm install
cd ../comments && npm install
cd ../query && npm install
cd ../moderation && npm install
cd ../event-bus && npm install
```

## Déploiement

### Étape 1 — Construction des images Docker  

- **Depuis la racine du projet** :

```bash
docker build -t client ./client
docker build -t posts ./posts
docker build -t comments ./comments
docker build -t query ./query
docker build -t moderation ./moderation
docker build -t event-bus ./event-bus
```

### Étape 2 — Déploiement sur Kubernetes  

- **Depuis le dossier `infra/k8s`** :

```bash
cd infra/k8s
kubectl apply -f .
```

## Accès à l'application

Le domaine par défaut est `localhost` (défini dans `infra/k8s/ingress-srv.yaml`).

### Pour utiliser `http://localhost`

Accédez à l'interface via :  
[http://localhost](http://localhost)

---

## Installation du NGINX Ingress Controller

Si vous ne l’avez pas déjà installé, exécutez :

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml
```

Vérifiez que tout est bien lancé :

```bash
kubectl get pods -n ingress-nginx
```

## Utilisation de `curl`

Pour créer un post via la ligne de commande avec **curl**, voici la commande à exécuter dans **Git Bash** :

```bash
curl -X POST http://localhost/posts/create -H "Content-Type: application/json" -d '{"title":"Test"}'
```

Si la requête est réussie, vous recevrez une réponse avec l'ID et le titre du post :

```json
{
  "id": "e33a5526",
  "title": "Test"
}
```

---

## Lancement des scripts (BONUS)

- Depuis la racine du projet :

```bash
./k8s-reset-total.sh      # Réinitialise le cluster
./build-and-deploy.sh     # Build et déploie tous les services
```

---

Projet réalisé dans le cadre du **Master Dev IA — Groupe 6**.
