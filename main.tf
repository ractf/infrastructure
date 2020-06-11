resource "aws_acm_certificate" "cert" {
  domain_name       = "asd"
  validation_method = "DNS"
  provider = aws.cert

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}