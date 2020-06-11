module "frontend" {
    source = "./modules/aws/frontend"
    deployment_name = var.RACTF_DOMAIN
}