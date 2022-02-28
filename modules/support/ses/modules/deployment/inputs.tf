variable "domain" {
  type        = string
  description = "The domain name to use when sending email"
}

variable "zone_id" {
  type        = string
  description = "The Zone ID to use when setting DNS"
}

variable "user" {
  type        = string
  description = "The ARN of the IAM user to grant email permissions to"
}

variable "backend_endpoint" {
  type        = string
  description = "The IP address of the RACTF backend"
}
