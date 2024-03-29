terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.2"
    }
  }
  required_version = ">= 1"
}
