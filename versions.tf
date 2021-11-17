terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65"
    }
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "~> 0.11"
    }
  }
  required_version = ">= 1"
}
