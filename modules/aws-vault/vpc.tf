data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group" "vault" {
  description = "Security group for Vault"
  name        = "${var.resource_name_prefix}-vault"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "vault_ssh_inbound" {
  description       = "Allow specified CIDRs SSH access to Vault nodes"
  security_group_id = aws_security_group.vault.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
}

resource "aws_security_group_rule" "vault_outbound" {
  description       = "Allow Vault nodes to send outbound traffic"
  security_group_id = aws_security_group.vault.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vault_internal_api" {
  description       = "Allow Vault nodes to reach other on port 8200 for API"
  security_group_id = aws_security_group.vault.id
  type              = "ingress"
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  self              = true
}

resource "aws_security_group_rule" "vault_application_lb_inbound" {
  description              = "Allow load balancer to reach Vault nodes on port 8200"
  security_group_id        = aws_security_group.vault.id
  type                     = "ingress"
  from_port                = 8200
  to_port                  = 8200
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vault_lb.id
}

resource "aws_security_group_rule" "vault_internal_raft" {
  description       = "Allow Vault nodes to communicate on port 8201 for replication traffic, request forwarding, and Raft gossip"
  security_group_id = aws_security_group.vault.id
  type              = "ingress"
  from_port         = 8201
  to_port           = 8201
  protocol          = "tcp"
  self              = true
}

resource "aws_security_group" "vault_lb" {
  description = "Security group for the application load balancer"
  name        = "${var.resource_name_prefix}-vault-lb-sg"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "vault_lb_inbound" {
  description       = "Allow specified CIDRs access to load balancer on port 8200"
  security_group_id = aws_security_group.vault_lb.id
  type              = "ingress"
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
}

resource "aws_security_group_rule" "vault_lb_outbound" {
  description              = "Allow outbound traffic from load balancer to Vault nodes on port 8200"
  security_group_id        = aws_security_group.vault_lb.id
  type                     = "egress"
  from_port                = 8200
  to_port                  = 8200
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vault.id
}
