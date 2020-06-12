variable "RACTF_DOMAIN" {
  type    = string
  default = "2020.ractf.co.uk"
}

variable "RACTF_SHORTENER_DOMAIN" {
  type    = string
  default = "ractf.xyz"
}

variable "CLOUDFLARE_EMAIL" {
  type = string
}

variable "CLOUDFLARE_API_KEY" {
  type = string
}

variable "shortener_endpoint" {
  type        = string
  description = "The IP of the host the RACTF shortener is running on"
}

variable "ractf_host" {
  type        = string
  description = "The IP of the host the RACTF backend is running on"
}

variable "mail_host" {
  type        = string
  description = "The IP of the host the RACTF email services are running on"
}

