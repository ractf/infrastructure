variable "deployment_name" {
  type        = string
  description = "The name of the RACTF deployment"
}

variable "zone" {
  type        = string
  description = "The Cloudflare Zone ID"
}

variable "backend_endpoint" {
  type        = string
  description = "The IP address of the RACTF backend"
}

variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}
