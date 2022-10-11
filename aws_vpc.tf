locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "main"

  # 10.0.4.x = home network
  # 10.1.x.x = main VPC
  cidr = local.vpc_cidr

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = cidrsubnets(cidrsubnet(local.vpc_cidr, 4, 1), 4, 4)
  public_subnets  = cidrsubnets(cidrsubnet(local.vpc_cidr, 4, 0), 4, 4)

  enable_nat_gateway = true
}
