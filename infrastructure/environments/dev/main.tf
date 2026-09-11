module "project_services" {
  source = "../../modules/project-services"

  project_id = var.project_id

  services = [
    "run.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
}
