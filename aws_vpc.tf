data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  vpc_name = "main"

  vpc_cidr = cidrsubnet("10.0.0.0/8", 8, 0)

  public_subnets  = cidrsubnets(cidrsubnet(aws_vpc.this.ipv6_cidr_block, 1, 0), 7, 7, 7)
  private_subnets = cidrsubnets(cidrsubnet(aws_vpc.this.ipv6_cidr_block, 1, 1), 7, 7, 7)

  azs = sort(data.aws_availability_zones.available.names)
}

resource "aws_vpc" "this" {
  cidr_block = local.vpc_cidr

  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = length(local.public_cidr)

  vpc_id            = aws_vpc.this.id
  availability_zone = element(local.azs, count.index)
  ipv6_native       = true

  tags = {
    Name = "${local.vpc_name}-public-${element(local.azs, count.index)}"
  }
}

resource "aws_subnet" "private" {
  count = length(local.private_cidr)

  vpc_id            = aws_vpc.this.id
  availability_zone = element(local.azs, count.index)
  ipv6_native       = true

  tags = {
    Name = "${local.vpc_name}-private-${element(local.azs, count.index)}"
  }
}
