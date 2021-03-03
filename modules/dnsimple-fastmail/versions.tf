terraform {
  required_providers {
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "~> 0.5.1"
    }
  }
  required_version = ">= 0.13"
}
