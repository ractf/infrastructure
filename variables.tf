variable "root_domain" {
  type = string
}

variable "ractf_frontend_domain" {
  type = string
}

variable "ractf_elite_domain" {
  type = string
}

variable "ractf_shortener_domain" {
  type = string
}

variable "aws_region" {
  type        = string
  description = "Region to deploy AWS resources to"
}

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_key" {
  type = string
}

variable "shortener_endpoint" {
  type        = string
  description = "The IP of the host the RACTF shortener is running on"
}

variable "ractf_host" {
  type        = string
  description = "The IP of the host the RACTF backend is running on"
}

variable "mail_host" {
  type        = string
  description = "The IP of the host the RACTF email services are running on"
}

variable "google_token" {
  type        = string
  description = "Google verification token"
}

variable "github_token" {
  type        = string
  description = "GitHub verification token"
}

variable "deploy_account" {
  type        = string
  description = "The ARN of the S3 deploy account"
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

variable "dkim_key" {
  type        = string
  description = "DKIM token from mail server"
}
