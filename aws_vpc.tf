resource "aws_vpc" "main" {
  cidr_block = cidrsubnet("10.0.0.0/8", 8, 0)

  tags = {
    Name = "main"
  }
}
