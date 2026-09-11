output "workload_identity_provider" {
  description = "Identifiant complet du Workload Identity Provider."
  value       = google_iam_workload_identity_pool_provider.github.name
}

output "service_account_email" {
  description = "Adresse du compte de service utilisé par GitHub Actions."
  value       = google_service_account.github.email
}
