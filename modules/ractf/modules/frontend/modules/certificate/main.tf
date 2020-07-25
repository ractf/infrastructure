resource "aws_acm_certificate" "certificate" {
  domain_name       = "${var.deployment_name}.${var.root_domain}"
  validation_method = "DNS"

  tags = {
    Environment = "production"
    Deployment  = var.deployment_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "certificate-validation" {
  zone_id = var.zone
  name    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
  value   = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value
  type    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  proxied = false
}

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [cloudflare_record.certificate-validation.hostname]
}
