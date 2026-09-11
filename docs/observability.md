# Contrat d'observabilité

Ce document définit les règles d'observabilité que devront respecter les applications du projet.

L'objectif est de rendre les services observables indépendamment de la technologie utilisée.

## Principes

Chaque service devra fournir :

- des logs structurés ;
- des métriques ;
- des traces distribuées lorsque cela est pertinent ;
- un endpoint de contrôle de santé ;
- des informations permettant de corréler les requêtes entre services.

L'implémentation devra privilégier les standards ouverts.

## OpenTelemetry

OpenTelemetry sera privilégié pour l'instrumentation des applications.

Il permettra de collecter :

- les traces ;
- les métriques ;
- éventuellement les logs.

La technologie applicative pourra utiliser les SDK OpenTelemetry disponibles pour son environnement :

- Java ;
- Node.js ;
- Python ;
- autres technologies compatibles.

## Logs

Les applications devront écrire leurs logs dans :

- stdout ;
- stderr.

Les logs devront être structurés autant que possible, idéalement au format JSON.

Exemple :

```json
{
  "level": "info",
  "service": "backend",
  "environment": "dev",
  "message": "Requête traitée",
  "request_id": "abc-123",
  "duration_ms": 42
}
```

Les logs ne devront jamais contenir :

- mots de passe ;
- tokens ;
- clés API ;
- chaînes de connexion complètes ;
- données personnelles sensibles.

## Niveaux de logs

Les niveaux suivants devront être utilisés :

- DEBUG : informations de développement ;
- INFO : fonctionnement normal ;
- WARN : événement anormal mais non bloquant ;
- ERROR : erreur nécessitant une investigation.

Le niveau DEBUG ne devra pas être activé par défaut en production.

## Corrélation des requêtes

Chaque requête devra pouvoir être associée à un identifiant.

Exemple :

```text
request_id
```

ou via les identifiants de trace OpenTelemetry.

Cet identifiant devra être propagé entre les services lorsque plusieurs composants participent au traitement d'une même requête.

## Health checks

Chaque backend devra exposer :

```text
GET /health
```

Cet endpoint devra permettre de vérifier que le service est opérationnel.

À terme, deux niveaux pourront être distingués :

```text
/health/live
/health/ready
```

`live` indique que le processus fonctionne.

`ready` indique que le service est prêt à recevoir du trafic.

## Métriques

Les métriques minimales devront permettre de suivre :

- nombre de requêtes ;
- temps de réponse ;
- taux d'erreur ;
- consommation des ressources lorsque disponible ;
- état des dépendances importantes.

Les métriques métier pourront être ajoutées selon les besoins du projet.

## Traces

Lorsque l'application comporte plusieurs composants ou appels externes, les traces devront permettre de suivre le chemin complet d'une requête.

Exemple :

```text
Frontend
   ↓
Backend
   ↓
Database
   ↓
Service externe
```

OpenTelemetry sera utilisé afin d'éviter de dépendre directement d'une solution propriétaire.

## Environnements

Chaque événement observable devra permettre d'identifier :

```text
dev
staging
production
```

ainsi que le service concerné.

## Alertes

Les alertes seront définies uniquement pour des événements réellement exploitables.

Exemples :

- taux d'erreur anormal ;
- indisponibilité d'un service ;
- latence excessive ;
- échec répété d'une dépendance.

L'objectif est d'éviter des alertes inutiles ou trop fréquentes.

## Environnement local

Il n'est pas nécessaire de déployer immédiatement une stack complète Prometheus / Grafana.

Le développement local devra dans un premier temps permettre :

- l'affichage des logs ;
- la consultation des logs Docker ;
- le test des endpoints de santé.

Des outils supplémentaires pourront être ajoutés lorsque l'application réelle sera disponible.

## Cloud

Lors du déploiement sur Google Cloud, les applications devront pouvoir envoyer ou exposer leurs données d'observabilité vers les services appropriés.

L'instrumentation applicative devra cependant rester autant que possible indépendante du fournisseur cloud.

## Sécurité

Les systèmes d'observabilité ne doivent jamais devenir une source de fuite de secrets.

Les données suivantes doivent être filtrées :

- Authorization headers ;
- cookies sensibles ;
- mots de passe ;
- tokens ;
- secrets applicatifs ;
- informations personnelles sensibles.
