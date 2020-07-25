resource "cloudflare_zone" "root-domain" {
  zone = var.root_domain
}

module "frontend" {
  source          = "./modules/frontend"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
  deploy_account  = var.deploy_account
  providers = {
    aws.cert = aws.cert
  }
}

module "static" {
  source          = "./modules/static"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.root-domain.id
  name    = "api-${var.deployment_name}"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}
