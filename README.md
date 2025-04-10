
# Projet fil rouge — Microservices avec Kubernetes

## Présentation

Ce projet est une application en microservices développée avec **Node.js** et **React**, déployée dans un environnement **Kubernetes**.  
Il a été réalisé dans le cadre du **Master Dev IA — Groupe 6**.

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
- [Scripts complémentaires](#scripts-complémentaires)
- [Installation du NGINX Ingress Controller](#installation-du-nginx-ingress-controller)
- [Lancement des scripts](#lancement-des-scripts)

## Architecture

L'application est composée des services suivants :

- **Client** : Interface utilisateur (React)
- **Posts** : Création de posts
- **Comments** : Ajout de commentaires
- **Query** : Regroupement des données
- **Moderation** : Modération automatique
- **Event Bus** : Système de communication entre services

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

## Prérequis

- Node.js
- Docker
- Kubernetes (via Docker Desktop ou Minikube)
- NGINX Ingress Controller

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

Le domaine par défaut est `posts.com` (défini dans `infra/k8s/ingress-srv.yaml`).

### Pour utiliser `http://posts.com`

Modifier le fichier `hosts` de votre système.

#### Sous Windows :
1. Ouvrir Bloc-notes en **administrateur**
2. Modifier le fichier : `C:\Windows\System32\drivers\etc\hosts`
3. Ajouter cette ligne à la fin du fichier :
```
127.0.0.1 posts.com
```

#### Sous Mac/Linux :
```bash
sudo nano /etc/hosts
```
Ajouter :
```
127.0.0.1 posts.com
```

Accès à l’interface : [http://posts.com](http://posts.com)

### Option alternative

Vous pouvez remplacer `posts.com` par `localhost` dans le fichier `infra/k8s/ingress-srv.yaml`.

Accès ensuite : [http://localhost:3000](http://localhost:3000)

## Installation du NGINX Ingress Controller

Si vous ne l’avez pas déjà installé, exécutez :

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml
```

Vérifier que tout est bien lancé :

```bash
kubectl get pods -n ingress-nginx
```
## Scripts complémentaires (Bonus)
### Lancement des scripts

- Depuis la racine du projet :

```bash
./k8s-reset-total.sh      # Réinitialise le cluster
./build-and-deploy.sh     # Build et déploie tous les services
```

---

Projet réalisé dans le cadre du **Master Dev IA — Groupe 6**.
