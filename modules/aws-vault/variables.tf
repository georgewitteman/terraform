variable "fqdn" {
  type        = string
  description = "The fqdn where Vault will be accessed"
}

variable "resource_name_prefix" {
  type        = string
  description = "Resource name prefix used for naming AWS resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Vault will be deployed"
}

variable "lb_subnet_ids" {
  type        = list(string)
  description = "Subnets where load balancer will be deployed"
}

variable "vault_subnet_ids" {
  type        = list(string)
  description = "Private subnets where Vault will be deployed"
}

variable "lb_certificate_arn" {
  type        = string
  description = "ARN of TLS certificate imported into ACM for use with LB listener"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3a.nano"
}

variable "ssh_key_name" {
  type        = string
  description = "key pair to use for SSH access to instance"
  default     = null
}
