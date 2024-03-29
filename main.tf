module "homepage" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "www"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  error_page          = "/404.html"
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "install" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "install"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "javadoc_api" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "polaris-api"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "javadoc_controller" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "polaris-controller"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "javadoc_client" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "polaris-apiclient"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "docs" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "docs"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  react               = true
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "ui_kit" {
  source             = "./modules/ractf/modules/frontend"
  deployment_name    = "ui-kit"
  deploy_account     = var.deploy_account
  root_domain        = var.root_domain
  zone               = module.dns.zone
  viewer_request_arn = module.lambda.viewer_request_arn
  react              = true
  ractf_domains      = var.ractf_domains
  cache_policy       = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "cloud_homepage" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "www"
  deploy_account      = var.deploy_account
  root_domain         = var.cloud_domain
  zone                = module.cloud_dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
  }
}

module "deployment" {
  for_each            = var.deployments
  source              = "./modules/ractf"
  deployment_name     = each.value.name
  root_domain         = each.value.domain
  backend_endpoint    = var.ractf_host
  deploy_account      = var.deploy_account
  zone                = each.value.domain == var.root_domain ? module.dns.zone : module.cloud_dns.zone
  container_registry  = each.value.container_registry
  backend_account     = module.ses.backend_account
  new_relic_policy_id = module.newrelic.policy_id
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  ractf_domains       = var.ractf_domains
  cache_policy        = module.lambda.cache_policy_arn
  unique_name         = each.key
  providers = {
    aws        = aws
    aws.cert   = aws.cert
    cloudflare = cloudflare
    newrelic   = newrelic
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
  consul_host         = var.consul_host
  mail_frontend       = var.mail_frontend
  atlassian_token     = var.atlassian_token
  dmarc_record        = var.dmarc_record
  balloon_host        = var.consul_host
  careers_endpoint    = var.careers_endpoint
}

module "cloud_dns" {
  source           = "./modules/support/dns"
  domain           = var.cloud_domain
  mail_endpoint    = var.mail_host
  github_token     = var.cloud_github_token
  google_token     = var.cloud_google_token
  staging_endpoint = var.staging_endpoint
  dmarc_record     = var.dmarc_record
}

module "staging_dns" {
  source           = "./modules/support/dns"
  domain           = var.staging_domain
  mail_endpoint    = var.mail_host
  github_token     = var.cloud_github_token
  google_token     = var.cloud_google_token
  staging_endpoint = var.staging_endpoint
  dmarc_record     = var.dmarc_record
  create_home      = false
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

module "staging" {
  source           = "./modules/support/staging"
  zone             = module.staging_dns.zone
  staging_endpoint = var.staging_endpoint
}

module "vault" {
  source      = "./modules/support/vault"
  bucket_name = var.vault_bucket
}

module "ses" {
  source           = "./modules/support/ses"
  domains          = { (var.root_domain) = (module.dns.zone), (var.cloud_domain) = (module.cloud_dns.zone) }
  backend_endpoint = var.ractf_host
}

#module "consul" {
#  source = "./modules/support/consul"
#}

module "newrelic" {
  source      = "./modules/support/newrelic"
  discord_url = var.discord_url
}

module "lambda" {
  source = "./modules/support/lambda"
  prefix = "ractf"
  providers = {
    aws = aws.cert
  }
}

#module "nomad" {
#  source = "./modules/support/nomad"
#}
