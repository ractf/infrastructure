variable "zone" {
  type        = number
  description = "The zone ID being edited"
}

variable "shortener" {
  type        = bool
  description = "Whether the domain is a shortener"
  default     = false
}
