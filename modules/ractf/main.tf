module "frontend" {
  source          = "./modules/frontend"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
  deploy_account  = var.deploy_account
  zone            = var.zone
}

module "static" {
  source          = "./modules/static"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
  zone            = var.zone
}

module "registry" {
  source = "./modules/container"
  deployment_name = var.deployment_name
  count = var.container_registry ? 1 : 0
}

resource "cloudflare_record" "api" {
  zone_id = var.zone
  name    = "api-${var.deployment_name}"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}
