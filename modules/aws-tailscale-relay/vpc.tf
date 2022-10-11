data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group" "this" {
  description = "Security group for the subnet router"
  name        = "${var.resource_name_prefix}-tailscale"
  vpc_id      = data.aws_vpc.selected.id
}

resource "aws_security_group_rule" "outbound" {
  description       = "Allow Tailscale relay to send outbound traffic anywhere"
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh_inbound" {
  description       = "Allow specified CIDRs SSH access"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
