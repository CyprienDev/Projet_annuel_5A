# Contrat de déploiement

Ce document définit les règles communes que devront respecter les applications du projet afin de rester indépendantes de la technologie utilisée.

## Backend

Le backend devra :

* être conteneurisé avec Docker ;
* exposer une API HTTP ;
* écouter sur un port configurable via variable d'environnement ;
* exposer un endpoint de contrôle de santé `/health` ;
* recevoir sa configuration via des variables d'environnement ;
* écrire ses logs dans `stdout` et `stderr` ;
* ne pas stocker de données persistantes dans le conteneur ;
* utiliser une base de données ou un stockage externe lorsque nécessaire.

La technologie du backend pourra être définie ultérieurement, par exemple :

* Java / Spring Boot ;
* Node.js / Fastify ;
* Python / FastAPI ;
* Python / Flask ;
* autre technologie compatible avec ces contraintes.

## Frontend

Deux modes de déploiement devront être supportés.

### Frontend statique

Pour les applications pouvant être compilées sous forme de fichiers statiques.

Exemples :

* Angular ;
* SPA JavaScript / TypeScript ;
* Next.js en export statique.

Le résultat de la compilation devra pouvoir être servi depuis un hébergement statique.

### Frontend conteneurisé

Pour les applications nécessitant un serveur d'exécution.

Exemples :

* Next.js avec rendu côté serveur ;
* application Node.js servant le frontend.

L'application devra alors respecter les mêmes principes de conteneurisation que le backend.

## Configuration

Les paramètres dépendant de l'environnement ne devront pas être stockés directement dans le code.

Exemples :

* URL de base de données ;
* URL d'API ;
* clés d'API ;
* configuration des services externes.

Ils devront être fournis via des variables d'environnement ou un système de gestion des secrets.

## Secrets

Aucun secret ne devra être versionné dans Git.

Les secrets devront être stockés dans une solution dédiée du fournisseur cloud ou dans le système CI/CD.

## Données

Les conteneurs applicatifs devront être considérés comme éphémères.

Les données persistantes devront être stockées dans des services externes :

* base de données ;
* stockage objet ;
* stockage de fichiers ;
* autres services persistants.

## Objectif

L'objectif de ce contrat est de permettre à l'infrastructure et aux pipelines CI/CD de fonctionner indépendamment de la technologie choisie pour le frontend et le backend.
