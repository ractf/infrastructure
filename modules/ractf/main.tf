module "frontend" {
  source              = "./modules/frontend"
  root_domain         = var.root_domain
  deployment_name     = var.deployment_name
  deploy_account      = var.deploy_account
  zone                = contains(var.ractf_domains, var.root_domain) ? var.zone : cloudflare_zone.domain[0].id
  origin_response_arn = var.origin_response_arn
  viewer_request_arn  = var.viewer_request_arn
  react               = true
  ractf_domains       = var.ractf_domains
  cache_policy        = var.cache_policy
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "static" {
  source              = "./modules/static"
  root_domain         = var.root_domain
  deployment_name     = var.deployment_name
  backend_account     = var.backend_account
  origin_response_arn = var.origin_response_arn
  zone                = contains(var.ractf_domains, var.root_domain) ? var.zone : cloudflare_zone.domain[0].id
  ractf_domains       = var.ractf_domains
  cache_policy        = var.cache_policy
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "backend" {
  source              = "./modules/backend"
  root_domain         = var.root_domain
  deployment_name     = var.deployment_name
  backend_endpoint    = var.backend_endpoint
  zone                = contains(var.ractf_domains, var.root_domain) ? var.zone : cloudflare_zone.domain[0].id
  new_relic_policy_id = var.new_relic_policy_id
}

module "registry" {
  source          = "./modules/container"
  deployment_name = var.deployment_name
  count           = var.container_registry ? 1 : 0
}

resource "cloudflare_zone" "domain" {
  zone  = var.root_domain
  count = contains(var.ractf_domains, var.root_domain) ? 0 : 1
}
