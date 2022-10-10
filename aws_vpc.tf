resource "aws_vpc" "this" {
  # 10.0.4.x = home network
  # 10.1.x.x = main VPC
  cidr_block = "10.1.0.0/16"
}
