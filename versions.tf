terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "~> 0.11"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.3"
    }
  }
  required_version = ">= 1"
}
