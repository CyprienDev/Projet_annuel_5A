resource "google_service_account" "github" {
  project = var.project_id

  account_id   = var.service_account_id
  display_name = "GitHub Actions Deployer"
  description  = "Compte de service utilisé par GitHub Actions via Workload Identity Federation."
}

resource "google_iam_workload_identity_pool" "github" {
  project = var.project_id

  workload_identity_pool_id = var.pool_id
  display_name              = "GitHub Actions"
  description               = "Identités fédérées provenant de GitHub Actions."
}

resource "google_iam_workload_identity_pool_provider" "github" {
  project = var.project_id

  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id

  display_name = "GitHub"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.ref"        = "assertion.ref"
  }

  attribute_condition = "assertion.repository == '${var.github_repository}' && assertion.ref == 'refs/heads/main'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "github" {
  service_account_id = google_service_account.github.name

  role = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_repository}"
}
