module "frontend" {
    source = "./modules/aws/frontend"
    deployment_name = var.RACTF_DOMAIN
    certificate = certificate
}

module "certificate" {
    source = "./modules/aws/certificate"
    domain = var.RACTF_DOMAIN
    providers = {
        aws = aws.cert
    }
}