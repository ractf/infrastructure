resource "aws_acm_certificate" "certificate" {
  domain_name       = "${var.deployment_name}.${var.root_domain}"
  validation_method = "DNS"

  tags = {
    Environment = "production"
    Deployment  = var.deployment_name != "*" ? var.deployment_name : "wildcard"
  }

  lifecycle {
    create_before_destroy = true
  }
  provider = aws.cert
}

resource "cloudflare_record" "certificate-validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  value   = each.value.record
  type    = each.value.type
  zone_id = var.zone
  proxied = false
}

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in cloudflare_record.certificate-validation : record.hostname]
  provider = aws.cert
}
