module "project_services" {
  source = "../../modules/project-services"

  project_id = var.project_id

  services = [
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com"
  ]
}

module "github_wif" {
  source = "../../modules/github-wif"

  project_id        = var.project_id
  github_repository = var.github_repository

  depends_on = [
    module.project_services
  ]
}
