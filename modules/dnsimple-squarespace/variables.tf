variable "domain" {
  type        = string
  description = "The root zone for this site"
}

variable "verify_cname" {
  type        = string
  description = "Verify CNAME host"
}

variable "ttl" {
  type        = number
  description = "TTL for records"
  default     = 60 * 5
}
