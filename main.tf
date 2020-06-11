module "frontend" {
    source = "./modules/aws/frontend"
    deployment_name = var.RACTF_DOMAIN
    providers = {
        aws.cert = aws.cert
    }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.deployment_name
  validation_method = "DNS"
  provider = aws.cert

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}