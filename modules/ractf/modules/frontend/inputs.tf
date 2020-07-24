variable "deployment_name" {
  type        = string
  description = "The domain name to use when deploying the frontend"
}

variable "deploy_account" {
  type        = string
  description = "The ARN of the S3 deploy account"
}

variable "root_domain" {
  type = string
  description = "The root domain for the RACTF deployment"
}
