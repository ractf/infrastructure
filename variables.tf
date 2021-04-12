variable "root_domain" {
  type        = string
  description = "The RACTF root domain"
}

variable "cloud_domain" {
  type        = string
  description = "The RACTF Cloud domain"
}

variable "staging_domain" {
  type        = string
  description = "The RACTF staging domain"
}

variable "ractf_shortener_domain" {
  type        = string
  description = "The RACTF Shortener domain"
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
  type        = list(string)
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

variable "cloud_google_token" {
  type        = list(string)
  description = "Google verification token for Cloud"
}

variable "cloud_github_token" {
  type        = string
  description = "GitHub verification token for Cloud"
}

variable "vault_bucket" {
  type        = string
  description = "The name of the bucket for Vault"
}

variable "deployments" {
  type        = map(object({ name = string, domain = string, container_registry = bool }))
  description = "Events running on the RACTF site"
}

variable "consul_host" {
  type        = string
  description = "The host running the Consul and Nomad proxies"
  default     = ""
}

variable "consul_address" {
  type        = string
  description = "The host running Consul"
  default     = ""
}

variable "consul_token" {
  type        = string
  description = "ACL token for Consul"
  default     = ""
}

variable "consul_auth" {
  type        = string
  description = "HTTP Auth credentials for Consul"
  default     = ""
}

variable "consul_cert" {
  type        = string
  description = "PEM encoded certificate for mTLS"
  default     = ""
}

variable "consul_key" {
  type        = string
  description = "PEM encoded key for mTLS"
  default     = ""
}

variable "nomad_address" {
  type        = string
  description = "The host running Nomad"
  default     = ""
}

variable "nomad_token" {
  type        = string
  description = "ACL token for Consul"
  default     = ""
}

variable "new_relic_id" {
  type        = number
  description = "ID of New Relic account"
  default     = 1
}

variable "new_relic_key" {
  type        = string
  description = "Key for New Relic account"
  default     = ""
}

variable "discord_url" {
  type        = string
  description = "Webhook for Discord alerting"
  default     = ""
}

variable "mail_frontend" {
  type        = string
  description = "The IP of the host the RACTF mail frontend is running on"
  default     = ""
}

variable "atlassian_token" {
  type        = string
  description = "The verification token for Atlassian"
  default     = ""
}

variable "dmarc_record" {
  type        = string
  description = "The DMARC record"
  default     = ""
}
