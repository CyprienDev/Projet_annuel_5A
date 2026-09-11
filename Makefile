SHELL := /bin/bash

.PHONY: help doctor setup up down logs status test \
        tofu-fmt tofu-validate tflint hadolint security check

help:
	@echo ""
	@echo "Commandes disponibles :"
	@echo "  make doctor         Vérifie les outils nécessaires"
	@echo "  make setup          Initialise l'environnement local"
	@echo "  make up             Démarre PostgreSQL et l'API"
	@echo "  make down           Arrête l'environnement local"
	@echo "  make logs           Affiche les logs Docker"
	@echo "  make test           Teste l'endpoint /health"
	@echo "  make tofu-fmt       Vérifie le format OpenTofu"
	@echo "  make tofu-validate  Valide l'infrastructure"
	@echo "  make tflint         Analyse l'infrastructure"
	@echo "  make hadolint       Analyse le Dockerfile"
	@echo "  make security       Lance Trivy"
	@echo "  make check          Lance les principaux contrôles"
	@echo ""

doctor:
	@echo "Vérification des outils..."
	@command -v git >/dev/null || (echo "❌ Git manquant" && exit 1)
	@command -v docker >/dev/null || (echo "❌ Docker manquant" && exit 1)
	@command -v tofu >/dev/null || (echo "❌ OpenTofu manquant" && exit 1)
	@command -v tflint >/dev/null || (echo "❌ TFLint manquant" && exit 1)
	@command -v hadolint >/dev/null || (echo "❌ Hadolint manquant" && exit 1)
	@command -v trivy >/dev/null || (echo "❌ Trivy manquant" && exit 1)
	@echo "✅ Tous les outils nécessaires sont disponibles."

setup:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "✅ Fichier .env créé depuis .env.example"; \
	else \
		echo "ℹ️  Le fichier .env existe déjà"; \
	fi
	@tofu -chdir=infrastructure/environments/dev init
	@echo "✅ Environnement local initialisé."

up:
	docker compose --env-file .env -f docker/compose.dev.yml up -d --build

down:
	docker compose --env-file .env -f docker/compose.dev.yml down

logs:
	docker compose --env-file .env -f docker/compose.dev.yml logs -f

test:
	@curl --fail http://localhost:8080/health
	@echo ""
	@echo "✅ API opérationnelle."

tofu-fmt:
	tofu fmt -check -recursive infrastructure/

tofu-validate:
	tofu -chdir=infrastructure/environments/dev init -backend=false
	tofu -chdir=infrastructure/environments/dev validate

tflint:
	cd infrastructure/environments/dev && \
	tflint --init --config=../../.tflint.hcl && \
	tflint --config=../../.tflint.hcl

hadolint:
	hadolint examples/smoke-api/Dockerfile

security:
	trivy fs --severity HIGH,CRITICAL .

check: tofu-fmt tofu-validate tflint hadolint security
	@echo ""
	@echo "✅ Tous les contrôles sont passés."

status:
	docker compose --env-file .env -f docker/compose.dev.yml ps
