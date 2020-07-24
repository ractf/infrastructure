resource "cloudflare_zone" "root-domain" {
  zone = var.root_domain
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = "${var.domain}.ractf.co.uk"
  validation_method = "DNS"

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "certificate-validation" {
  zone_id = cloudflare_zone.root-domain.id
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  value   = aws_acm_certificate.cert.domain_validation_options.0.resource_record_value
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  proxied = false
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
