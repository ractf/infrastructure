variable "deployment_name" {
    type = string
    description = "The domain name to use when deploying the frontend"
}

variable "certificate" {
    type = string
    description = "The ARN of the certificate to use when deploying the frontend"
}