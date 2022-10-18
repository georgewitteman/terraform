variable "zone_id" {
  type        = string
  description = "Hosted Zone ID of the desired Hosted Zone"
}

variable "ttl" {
  type        = number
  description = "TTL for records"
  default     = 60 * 5
}
