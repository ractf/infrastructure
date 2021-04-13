variable "deployment_name" {
  type        = string
  description = "The name of the RACTF deployment"
}

variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}

variable "zone" {
  type        = string
  description = "The Cloudflare Zone ID"
}

variable "ractf_domains" {
  type        = list(string)
  description = "A list of the RACTF domains"
}
