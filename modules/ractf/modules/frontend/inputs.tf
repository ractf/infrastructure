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

variable "indexflatten" {
  type        = bool
  description = "Apply a Lambda add index.html"
  default     = false
}

variable "origin-response-arn" {
  type        = string
  description = "ARN of the Origin Response Lambda"
}

variable "viewer-request-arn" {
  type        = string
  description = "ARN of the Viewer Request Lambda"
}
