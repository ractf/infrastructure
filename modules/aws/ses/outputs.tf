output "domain_token" {
  description = "The domain verification token"
  value = aws_ses_domain_identity.ractf.verification_token
}
