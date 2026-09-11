variable "project_id" {
  description = "Identifiant du projet Google Cloud."
  type        = string
}

variable "github_repository" {
  description = "Dépôt GitHub autorisé au format owner/repository."
  type        = string
}

variable "pool_id" {
  description = "Identifiant du Workload Identity Pool."
  type        = string
  default     = "github-pool"
}

variable "provider_id" {
  description = "Identifiant du Workload Identity Provider."
  type        = string
  default     = "github-provider"
}

variable "service_account_id" {
  description = "Identifiant du compte de service utilisé par GitHub Actions."
  type        = string
  default     = "github-deployer"
}
