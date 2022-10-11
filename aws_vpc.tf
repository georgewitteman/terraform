resource "aws_vpc" "this" {
  # 10.0.4.x = home network
  # 10.1.x.x = main VPC
  cidr_block = "10.1.0.0/16"
}

module "public_subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, 0)
  networks = [
    {
      name     = "us-east-1a"
      new_bits = 4
    },
    {
      name     = "us-east-1b"
      new_bits = 4
    },
    {
      name     = "us-east-1c"
      new_bits = 4
    },
  ]
}

resource "aws_subnet" "public" {
  for_each = module.public_subnet_addrs.network_cidr_blocks

  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "public-${each.key}"
  }
}

module "private_subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, 1)
  networks = [
    {
      name     = "us-east-1a"
      new_bits = 4
    },
    {
      name     = "us-east-1b"
      new_bits = 4
    },
    {
      name     = "us-east-1c"
      new_bits = 4
    },
  ]
}

resource "aws_subnet" "private" {
  for_each = module.private_subnet_addrs.network_cidr_blocks

  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "private-${each.key}"
  }
}
