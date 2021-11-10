variable "domain" {
  type        = string
  description = "The domain that fastmail DNS records are being applied to"
}

variable "ttl" {
  type        = number
  description = "TTL for records"
  default     = 60 * 5
}
