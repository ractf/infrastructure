variable "domain" {
  type        = string
  description = "The domain RACTF is being deployed on"
}

variable "mail_endpoint" {
  type        = string
  description = "The IP of the host the RACTF mail service is running on"
  default = ""
}

variable "github_token" {
  type        = string
  description = "The verification token for GitHub"
  default = ""
}

variable "google_token" {
  type        = string
  description = "The verification token for Google"
  default = ""
}

variable "ses_token" {
  type        = string
  description = "The verification token for Amazon SES"
  default = ""
}

variable "staging_endpoint" {
  type        = string
  description = "The IP of the staging server"
  default = ""
}

variable "status_endpoint" {
  type        = string
  description = "The DNS name of the statuspage"
  default = ""
}

variable "h1_token_production" {
  type        = string
  description = "HackerOne verification token for Production"
  default = ""
}

variable "h1_token_staging" {
  type        = string
  description = "HackerOne verification token for Staging"
  default = ""
}

variable "ses_dkim_records" {
  type        = list(string)
  description = "DKIM keys from SES"
  default = [""]
}

variable "dkim_key" {
  type        = string
  description = "DKIM token from mail server"
  default = ""
}
