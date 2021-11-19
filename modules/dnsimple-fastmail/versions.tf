terraform {
  required_providers {
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "~> 0.10"
    }
  }
  required_version = ">= 1"
}
