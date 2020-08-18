variable "domains" {
  type        = list(string)
  description = "The domain names to use when sending email"
}

variable "zone" {
  type        = list(string)
  description = "The Zone IDs to use when setting DNS"
}
