variable "zone" {
  type        = string
  description = "The zone ID being edited"
}

variable "domain" {
  type        = string
  description = "The domain being edited"
}

variable "shortener" {
  type        = bool
  description = "Whether the domain is a shortener"
  default     = false
}
