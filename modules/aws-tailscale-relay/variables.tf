variable "vpc_id" {
  type        = string
  description = "VPC ID where Vault will be deployed"
}

variable "authkey" {
  type        = string
  description = "Tailscale pre-authorization key"
  sensitive   = true
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs to place the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"

  # The cheapest instance I could find
  default = "t3a.nano"
}

variable "ssh_key_name" {
  type        = string
  description = "key pair to use for SSH access to instance"
  default     = null
}

variable "resource_name_prefix" {
  type        = string
  description = "Resource name prefix used for naming AWS resources"
}
