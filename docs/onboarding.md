# Installation de l'environnement de développement

Ce document décrit les étapes nécessaires pour préparer un poste de développement.

## Prérequis

Les outils suivants sont utilisés par le projet :

- Git
- Docker
- OpenTofu
- TFLint
- Hadolint
- Trivy

Google Cloud CLI est nécessaire uniquement pour les personnes travaillant sur l'infrastructure cloud.

## Installation sur macOS

```bash
brew install opentofu
brew install terraform-linters/tap/tflint
brew install hadolint
brew install trivy
brew install --cask docker
```

Pour Google Cloud :

```bash
brew install --cask gcloud-cli
```

## Initialisation

Cloner le dépôt puis exécuter :

```bash
make doctor
make setup
```

Le fichier `.env` local sera créé à partir de `.env.example`.

Les secrets et paramètres locaux présents dans `.env` ne doivent jamais être versionnés.

## Démarrer l'environnement

```bash
make up
```

L'environnement local démarre notamment :

- PostgreSQL ;
- l'API de test.

## Vérifier l'API

```bash
make test
```

## Afficher les logs

```bash
make logs
```

## Arrêter l'environnement

```bash
make down
```

## Contrôles qualité

Avant de créer une Pull Request :

```bash
make check
```

Cette commande exécute les principaux contrôles également présents dans la CI.

## Infrastructure cloud

L'infrastructure est gérée avec OpenTofu.

L'état OpenTofu est actuellement local.

Un seul responsable infrastructure doit donc exécuter les commandes `tofu apply` tant qu'un backend distant partagé n'a pas été configuré.

Ne jamais versionner :

- `.terraform/`
- `*.tfstate`
- `*.tfstate.*`
- des fichiers de credentials Google Cloud
- `.env`
