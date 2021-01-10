module "frontend" {
  source          = "./modules/frontend"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
  deploy_account  = var.deploy_account
  zone            = var.zone
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "static" {
  source          = "./modules/static"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
  backend_account = var.backend_account
  zone            = var.zone
}

module "registry" {
  source          = "./modules/container"
  deployment_name = var.deployment_name
  count           = var.container_registry ? 1 : 0
}

module "backend" {
  source           = "./modules/backend"
  deployment_name  = var.deployment_name
  zone             = var.zone
  backend_endpoint = var.backend_endpoint
  root_domain      = var.root_domain
}
