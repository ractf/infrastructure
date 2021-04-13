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
  default     = ""
}

variable "viewer_request_arn" {
  type        = string
  description = "ARN of the Viewer Request Lambda"
  default     = ""
}

variable "error_page" {
  type        = string
  description = "The path of the document to serve as the error page"
  default     = "/index.html"
}

variable "ractf_domains" {
  type        = list(string)
  description = "A list of the RACTF domains"
}

variable "cache_policy" {
  type        = string
  description = "ID of RACTF cache policy"
}
