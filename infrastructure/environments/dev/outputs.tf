output "github_workload_identity_provider" {
  description = "Provider utilisé par GitHub Actions pour s'authentifier auprès de GCP."
  value       = module.github_wif.workload_identity_provider
}

output "github_service_account_email" {
  description = "Compte de service utilisé par GitHub Actions."
  value       = module.github_wif.service_account_email
}
