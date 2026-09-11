variable "project_id" {
  description = "Identifiant du projet Google Cloud."
  type        = string
}

variable "region" {
  description = "Région Google Cloud utilisée pour le déploiement."
  type        = string
  default     = "europe-west1"
}

variable "environment" {
  description = "Environnement de déploiement."
  type        = string
  default     = "dev"
}