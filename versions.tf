terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.30.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.5.0"
    }
  }
  required_version = ">= 0.13"
}
