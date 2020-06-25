resource "aws_ses_domain_identity" "ractf" {
  domain = var.domain
}