variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}

variable "deployment_name" {
  type        = string
  description = "The domain name to use when deploying the frontend"
}

variable "zone" {
  type        = string
  description = "The Cloudflare Zone ID"
}

variable "backend_account" {
  type        = string
  description = "The ARN of the S3 deploy account"
  default     = ""
}

variable "origin_response_arn" {
  type        = string
  description = "ARN of the Origin Response Lambda"
  default     = ""
}

variable "ractf_domains" {
  type        = list(string)
  description = "A list of the RACTF domains"
}
