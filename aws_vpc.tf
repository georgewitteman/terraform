locals {
  # 10.0.4.x = home network
  # 10.1.x.x = main VPC
  vpc_cidr        = "10.1.0.0/16"
  vpc_name        = "main"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = cidrsubnets(cidrsubnet(local.vpc_cidr, 4, 1), 4, 4, 4)
  public_subnets  = cidrsubnets(cidrsubnet(local.vpc_cidr, 4, 0), 4, 4, 4)

  private_subnet_ipv6_prefixes = [0, 1, 2]
  public_subnet_ipv6_prefixes  = [3, 4, 5]
}

resource "aws_vpc" "this" {
  cidr_block                       = local.vpc_cidr
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_eip" "nat" {
  count = length(local.private_subnets)

  tags = {
    Name = "${local.vpc_name}-${element(local.azs, count.index)}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "private" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = element(local.azs, count.index)
  cidr_block        = element(local.private_subnets, count.index)

  ipv6_cidr_block = cidrsubnet(
    aws_vpc.this.ipv6_cidr_block,
    8,
    local.private_subnet_ipv6_prefixes[count.index],
  )

  tags = {
    Name = "${local.vpc_name}-private-${element(local.azs, count.index)}"
  }
}

resource "aws_subnet" "public" {
  count = length(local.public_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = element(local.azs, count.index)
  cidr_block        = element(local.public_subnets, count.index)

  ipv6_cidr_block = cidrsubnet(
    aws_vpc.this.ipv6_cidr_block,
    8,
    local.public_subnet_ipv6_prefixes[count.index],
  )

  tags = {
    Name = "${local.vpc_name}-public-${element(local.azs, count.index)}"
  }
}

resource "aws_nat_gateway" "this" {
  count = length(aws_eip.nat)

  allocation_id = element(aws_eip.nat, count.index).id
  subnet_id     = element(aws_subnet.public, count.index).id

  tags = {
    Name = "${local.vpc_name}-${element(local.azs, count.index)}"
  }
}

resource "aws_egress_only_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_route" "private_nat_gateway" {
  count = length(aws_nat_gateway.this)

  route_table_id         = element(aws_route_table.private, count.index).id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this, count.index).id
}

resource "aws_route" "private_egress_only_gateway" {
  count = length(aws_route_table.private)

  route_table_id              = element(aws_route_table.private, count.index).id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.this.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route" "public_internet_gateway_ipv6" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this.id
}

resource "aws_route_table" "private" {
  count = length(aws_nat_gateway.this)

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.vpc_name}-private-${element(local.azs, count.index)}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.vpc_name}-public"
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  route_table_id = element(aws_route_table.private, count.index).id
  subnet_id      = element(aws_subnet.private, count.index).id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public, count.index).id
}
