terraform {
  required_providers {
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "~> 0.9"
    }
  }
  required_version = ">= 1"
}
