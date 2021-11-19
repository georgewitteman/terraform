terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.66"
    }
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "~> 0.10"
    }
  }
  required_version = ">= 1"
}
