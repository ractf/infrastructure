module "frontend" {
  source              = "./modules/frontend"
  root_domain         = var.root_domain
  deployment_name     = var.deployment_name
  deploy_account      = var.deploy_account
  zone                = var.zone
  origin_response_arn = module.lambda.origin_response_arn
  viewer_request_arn  = module.lambda.viewer_request_arn
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

module "backend" {
  source              = "./modules/backend"
  root_domain         = var.root_domain
  deployment_name     = var.deployment_name
  backend_endpoint    = var.backend_endpoint
  zone                = var.zone
  new_relic_policy_id = var.new_relic_policy_id
}

module "registry" {
  source          = "./modules/container"
  deployment_name = var.deployment_name
  count           = var.container_registry ? 1 : 0
}
