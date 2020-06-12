resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}