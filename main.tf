module "homepage" {
  source              = "./modules/ractf/modules/frontend"
  deployment_name     = "www"
  deploy_account      = var.deploy_account
  root_domain         = var.root_domain
  zone                = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
    cloudflare = cloudflare
  }
}

module "install" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "install"
  deploy_account  = var.deploy_account
  root_domain     = var.root_domain
  zone            = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
    cloudflare = cloudflare
  }
}

module "docs" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "docs"
  deploy_account  = var.deploy_account
  root_domain     = var.root_domain
  zone            = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
    cloudflare = cloudflare
  }
}

module "bentestbucket" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "bentestbucket"
  deploy_account  = aws_iam_user.bentestuser.arn
  root_domain     = var.root_domain
  zone            = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
    cloudflare = cloudflare
  }
}

resource "aws_iam_user" "bentestuser" {
  name = "bentestuser"
  path = "/testing/"
}

module "keygen" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "keygen"
  deploy_account  = var.deploy_account
  root_domain     = var.root_domain
  zone            = module.dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
    cloudflare = cloudflare
  }
}

module "cloud_homepage" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "www"
  deploy_account  = var.deploy_account
  root_domain     = var.cloud_domain
  zone            = module.cloud_dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
    cloudflare = cloudflare
  }
}

module "cloud_wildcard" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "*"
  deploy_account  = var.deploy_account
  root_domain     = var.cloud_domain
  zone            = module.cloud_dns.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
  providers = {
    aws = aws
    aws.cert = aws.cert
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

module "consul" {
  source = "./modules/support/consul"
}

module "newrelic" {
  source      = "./modules/support/newrelic"
  discord_url = var.discord_url
}

module "lambda" {
  source = "./modules/support/lambda"
}
