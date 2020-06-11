module "frontend" {
    source = "./modules/aws/frontend"
    deployment_name = var.RACTF_DOMAIN
    providers = {
        aws = aws
        aws.useast1 = aws.useast1
    }
}