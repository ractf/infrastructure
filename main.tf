module "frontend" {
    source = "./modules/aws/frontend"
    deployment_name = vars.RACTF_DOMAIN
}