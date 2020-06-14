variable "ractf_domain" {
  type = string
}

variable "ractf_frontend_domain" {
  type = string
}

variable "ractf_shortener_domain" {
  type = string
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
  type = string
  description = "The ARN of the S3 deploy account"
}
