terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.11"
    }
  }
  required_version = ">= 1"
}
