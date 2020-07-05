output "domain_token" {
  description = "The domain verification token"
  value       = aws_ses_domain_identity.ractf.verification_token
}

output "dkim_records" {
  description = "The DKIM records from SES"
  value       = aws_ses_domain_dkim.ractf.dkim_tokens
}
