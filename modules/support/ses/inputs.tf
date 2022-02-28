variable "domains" {
  type        = map(string)
  description = "The domain names to use when sending email"
}

variable "backend_endpoint" {
  type        = string
  description = "The IP address of the RACTF backend"
}
