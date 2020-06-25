output "dkim_token" {
  description = "The DKIM verification token"
  value = aws_ses_domain_identity.ractf.verification_token
}
