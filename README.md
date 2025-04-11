# 🧪 Sujet de TP – Déploiement d'une application microservices avec Docker et Kubernetes

## 🎯 Objectif
L'objectif de ce TP est de conteneuriser une application composée de plusieurs microservices, puis de la déployer dans un cluster Kubernetes. Vous partirez d’un projet existant fourni sous forme d’archive (`spring-petclinic-k8s.zip`), contenant le code source de l’application, mais **sans fichiers Docker ni manifests Kubernetes prêts à l’emploi**.

---

## 🗂️ Contexte
Vous êtes nouvellement intégré à une équipe DevOps. Votre mission est de préparer et d’assurer le déploiement de l’application **Spring Petclinic** dans un environnement Kubernetes. Cette application repose sur une architecture microservices incluant :
- des services métiers (clients, vétérinaires, visites),


Chaque microservice est développé avec Spring Boot.

---

## 🚧 Travail demandé

### Partie 1 – Analyse du projet
- Explorez l’arborescence du projet pour repérer les différents microservices.
- Pour chaque service, identifiez :
  - les dépendances nécessaires à son exécution,
  - son port d’écoute,
  - ses variables d’environnement attendues,
  - ses interactions avec les autres services.

> **Livrable attendu** : un document listant les services et leurs caractéristiques techniques.

---

### Partie 2 – Conteneurisation
- Créez un `Dockerfile` pour chaque microservice.
- Le build doit être reproductible (build multi-étapes recommandé).
- Prévoyez une stratégie pour gérer les fichiers de configuration et les dépendances.
- Testez chaque image localement (via `docker run` ou `docker-compose` minimal).

> **Livrable attendu** : un dossier `docker/` contenant les Dockerfile pour chaque service.

---

### Partie 3 – Déploiement Kubernetes
- Créez les manifests YAML nécessaires pour déployer l’application dans un cluster Kubernetes :
  - Déploiements (`Deployment`)
  - Services (`Service`)
  - Configuration (`ConfigMap` ou `Secret`)
- Implémentez les fichiers nécessaires pour le fonctionnement en cluster local (type minikube ou Kind).

> **Livrable attendu** : un dossier `k8s/` contenant les fichiers YAML pour chaque service.