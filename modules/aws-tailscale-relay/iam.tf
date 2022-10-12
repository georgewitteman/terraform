resource "aws_iam_instance_profile" "tailscale" {
  name_prefix = "${var.resource_name_prefix}-tailscale"
  role        = aws_iam_role.instance_role.name
}

resource "aws_iam_role" "instance_role" {
  name_prefix        = "${var.resource_name_prefix}-tailscale"
  assume_role_policy = data.aws_iam_policy_document.instance_role.json
}

data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "kms" {
  name   = "${var.resource_name_prefix}-tailscale-relay-kms"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.kms.json
}

data "aws_iam_policy_document" "kms" {
  statement {
    effect = "Allow"

    actions = [
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:Decrypt",
    ]

    resources = [aws_kms_key.this.arn]
  }
}

resource "aws_iam_role_policy" "secrets_manager" {
  name   = "${var.resource_name_prefix}-tailscale-secrets-manager"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.secrets_manager.json
}

data "aws_iam_policy_document" "secrets_manager" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [aws_secretsmanager_secret.authkey.arn]
  }
}

resource "aws_iam_role_policy" "session_manager" {
  name   = "${var.resource_name_prefix}-tailscale-ssm"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.session_manager.json
}

data "aws_iam_policy_document" "session_manager" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]

    resources = ["*"]
  }
}
