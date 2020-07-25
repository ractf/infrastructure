variable "root_domain" {
  type        = string
  description = "The root domain for the RACTF deployment"
}

variable "deployment_name" {
  type        = string
  description = "The domain name to use when deploying the frontend"
}

variable "bucket_endpoint" {
  type        = string
  description = "The endpoint for the bucket"
}
