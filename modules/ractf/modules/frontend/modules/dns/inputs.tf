variable "endpoint" {
  type        = string
  description = "The endpoint for Cloudfront"
}

variable "deployment_name" {
  type        = string
  description = "The domain name to use when deploying the frontend"
}

variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}

variable "zone" {
  type        = string
  description = "The Cloudflare Zone ID"
}
