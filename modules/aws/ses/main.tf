resource "aws_ses_domain_identity" "ractf" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "ractf" {
  domain = aws_ses_domain_identity.ractf.domain
}
