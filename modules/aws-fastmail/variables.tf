variable "zone_id" {
  type        = string
  description = "Hosted Zone ID of the desired Hosted Zone"
}

variable "dmarc" {
  type        = string
  description = "The DMARC record from Postmark"
  default     = ""
}

variable "ttl" {
  type        = number
  description = "TTL for records"
  default     = 60 * 5
}
