variable "ractf_domain" {
  type    = string
  default = "2020.ractf.co.uk"
}

variable "ractf_shortener_domain" {
  type    = string
  default = "ractf.xyz"
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

variable "github_login_token" {
  type        = string
  description = "Token to login to GitHub"
}

variable "github_organization" {
  type        = string
  description = "GitHub organisation name"
}
