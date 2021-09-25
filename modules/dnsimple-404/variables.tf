variable "domain" {
  type        = string
  description = "The domain that fastmail DNS records are being applied to"
}

variable "ttl" {
  type        = number
  description = "TTL for records"
  default     = 60 * 5
}

variable "subdomain" {
  type        = string
  description = "The subdomain to link to 404.al"
  default     = "404"
}
