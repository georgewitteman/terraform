provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Repository = data.github_repository.terraform.full_name
      Terraform  = "true"
    }
  }
}
