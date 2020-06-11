module "frontend" {
    source = "./modules/frontend"
    deployment_name = vars.RACTF_DOMAIN
}