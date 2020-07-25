variable "domain" {
  type        = string
  description = "The domain RACTF is being deployed on"
}

variable "mail_endpoint" {
  type        = string
  description = "The IP of the host the RACTF mail service is running on"
}

variable "github_token" {
  type        = string
  description = "The verification token for GitHub"
}

variable "google_token" {
  type        = string
  description = "The verification token for Google"
}

variable "ses_token" {
  type        = string
  description = "The verification token for Amazon SES"
}

variable "staging_endpoint" {
  type        = string
  description = "The IP of the staging server"
}

variable "status_endpoint" {
  type        = string
  description = "The DNS name of the statuspage"
}

variable "h1_token_production" {
  type        = string
  description = "HackerOne verification token for Production"
}

variable "h1_token_staging" {
  type        = string
  description = "HackerOne verification token for Staging"
}

variable "ses_dkim_records" {
  type        = list(string)
  description = "DKIM keys from SES"
}

variable "dkim_key" {
  type        = string
  description = "DKIM token from mail server"
}
