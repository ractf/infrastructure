variable "deployment_name" {
  type        = string
  description = "The name of the RACTF deployment"
}

variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}

variable "backend_endpoint" {
  type        = string
  description = "The IP address of the RACTF backend"
}

variable "deploy_account" {
  type        = string
  description = "The ARN of the S3 deploy account"
}

variable "zone" {
  type        = string
  description = "The Cloudflare Zone ID"
}

variable "container_registry" {
  type        = bool
  description = "Should this deployment include a container registry?"
  default     = false
}

variable "backend_account" {
  type        = string
  description = "The ARN of the S3 deploy account"
  default     = ""
}

variable "new_relic_policy_id" {
  type        = string
  description = "New Relic Policy ID for Alerting"
}

variable "origin_response_arn" {
  type        = string
  description = "ARN of the Origin Response Lambda"
  default     = ""
}

variable "viewer_request_arn" {
  type        = string
  description = "ARN of the Viewer Request Lambda"
  default     = ""
}

variable "ractf_domains" {
  type        = list(string)
  description = "A list of the RACTF domains"
}
