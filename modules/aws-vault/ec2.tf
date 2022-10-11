locals {
  node_count = 3
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    # values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    # Hardware virtual machine
    # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/virtualization_types.html
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_template" "vault" {
  name                   = "${var.resource_name_prefix}-vault"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name != null ? var.ssh_key_name : null
  vpc_security_group_ids = [aws_security_group.vault.id]

  update_default_version = true

  user_data = base64encode(
    templatefile(
      "${path.module}/templates/install_vault.sh.tpl",
      {
        region                = data.aws_region.current.name
        name                  = var.resource_name_prefix
        vault_version         = "1.11.4"
        kms_key_arn           = aws_kms_key.this.arn
        secrets_manager_arn   = aws_secretsmanager_secret.tls.arn
        leader_tls_servername = var.fqdn
      }
    )
  )

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_type           = "gp3"
      volume_size           = 100
      throughput            = 150
      iops                  = 3000
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.vault.arn
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

resource "aws_autoscaling_group" "vault" {
  name                = "${var.resource_name_prefix}-vault"
  min_size            = local.node_count
  max_size            = local.node_count
  desired_capacity    = local.node_count
  vpc_zone_identifier = var.vault_subnet_ids
  target_group_arns   = [aws_lb_target_group.vault.arn]

  launch_template {
    id      = aws_launch_template.vault.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.resource_name_prefix}-vault-server"
    propagate_at_launch = true
  }
  tag {
    key                 = "${var.resource_name_prefix}-vault"
    value               = "server"
    propagate_at_launch = true
  }

}
