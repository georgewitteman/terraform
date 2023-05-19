terraform {
  backend "s3" {
    bucket  = "georgewitteman-terraform-state-v2"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = "true"
  }
}
