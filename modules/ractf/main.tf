resource "cloudflare_zone" "root-domain" {
  zone = var.root_domain
}

module "frontend" {
  source = "./modules/frontend"
  root_domain = var.ractf_domain
  deployment_name = var.deployment_name
}

module "static" {
  source = "./modules/static"
  root_domain = var.ractf_domain
  deployment_name = var.deployment_name
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.root-domain.id
  name    = "${var.deployment_name}.api"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}
