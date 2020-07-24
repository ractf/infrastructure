variable "deployment_name" {
    type = string
    description = "The name of the RACTF deployment"
}

variable "root_domain" {
    type = string
    description = "The root domain for the RACTF deployment"
}

variable "backend_endpoint" {
    type = string
    description = "The IP address of the RACTF backend"
}