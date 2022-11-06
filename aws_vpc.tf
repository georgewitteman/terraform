data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  vpc_name = "main"

  # Allows 2^8 VPCs. Probably overkill, but it matches AWS's default VPC CIDR
  # blocks (/16 VPC and /20 subnets)
  vpc_cidr = cidrsubnet("10.0.0.0/8", 8, 0)

  # The next bit determines whether its a public or private subnet
  private_cidr = cidrsubnet(local.vpc_cidr, 1, 0) # /17
  public_cidr  = cidrsubnet(local.vpc_cidr, 1, 1) # /17

  azs = sort(data.aws_availability_zones.available.names)
}

resource "aws_vpc" "main" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = element(local.azs, count.index)
  ipv6_native = true

  tags = {
    Name = "${local.vpc_name}-public-${element(local.azs, count.index)}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = element(local.azs, count.index)
  ipv6_native = true

  tags = {
    Name = "${local.vpc_name}-private-${element(local.azs, count.index)}"
  }
}
