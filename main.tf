module "deployment" {
  for_each           = var.deployments
  source             = "./modules/ractf"
  deployment_name    = each.value.name
  root_domain        = each.value.domain
  backend_endpoint   = var.ractf_host
  deploy_account     = var.deploy_account
  zone               = each.value.domain == var.root_domain ? module.dns.zone : module.cloud_dns.zone
  container_registry = each.value.container_registry
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "dns" {
  source              = "./modules/support/dns"
  domain              = var.root_domain
  mail_endpoint       = var.mail_host
  github_token        = var.github_token
  google_token        = var.google_token
  staging_endpoint    = var.staging_endpoint
  status_endpoint     = var.status_endpoint
  h1_token_production = var.h1_token_production
  h1_token_staging    = var.h1_token_staging
  dkim_key            = var.dkim_key
}

module "cloud_dns" {
  source           = "./modules/support/dns"
  domain           = var.cloud_domain
  mail_endpoint    = var.mail_host
  github_token     = var.cloud_github_token
  google_token     = var.cloud_google_token
  staging_endpoint = var.staging_endpoint
}

module "shortener_dns" {
  source   = "./modules/support/shortener"
  domain   = var.ractf_shortener_domain
  endpoint = var.shortener_endpoint
}

module "dns_settings" {
  source = "./modules/support/settings"
  zone   = module.dns.zone
  domain = var.root_domain
}

module "cloud_settings" {
  source = "./modules/support/settings"
  zone   = module.cloud_dns.zone
  domain = var.cloud_domain
}

module "shortener_settings" {
  source    = "./modules/support/settings"
  zone      = module.shortener_dns.zone
  domain    = var.ractf_shortener_domain
  shortener = true
}

module "vault" {
  source      = "./modules/support/vault"
  bucket_name = var.vault_bucket
}

module "ses" {
  source  = "./modules/support/ses"
  domains = { (var.root_domain) = (module.dns.zone), (var.cloud_domain) = (module.cloud_dns.zone) }
}
