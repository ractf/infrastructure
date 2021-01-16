variable "deployment_name" {
  type        = string
  description = "The domain name to use when deploying the frontend"
}

variable "deploy_account" {
  type        = string
  description = "The ARN of the S3 deploy account"
}

variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}

variable "zone" {
  type        = string
  description = "The Cloudflare Zone ID"
}

variable "react" {
  type        = bool
  description = "If the site being deployed uses React Router"
  default     = false
}

variable "origin_response_arn" {
  type        = string
  description = "ARN of the Origin Response Lambda"
}

variable "viewer_request_arn" {
  type        = string
  description = "ARN of the Viewer Request Lambda"
}
