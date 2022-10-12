provider "tailscale" {}

locals {
  relay_tag = "tag:aws-relay"
}

resource "tailscale_tailnet_key" "aws_relay" {
  reusable      = true
  ephemeral     = true
  preauthorized = true

  tags = [local.relay_tag]

  depends_on = [tailscale_acl.sample_acl]
}

module "tailscale_relay" {
  source = "./modules/aws-tailscale-relay"

  vpc_id               = aws_vpc.this.id
  authkey              = tailscale_tailnet_key.aws_relay.key
  resource_name_prefix = "main"
  public_subnet_ids    = aws_subnet.public[*].id
  ssh_key_name         = aws_key_pair.georgewitteman.key_name
}

resource "tailscale_acl" "sample_acl" {
  acl = jsonencode({
    acls = [
      {
        // Allow all users access to all ports.
        action = "accept",
        users  = ["*"],
        ports  = ["*:*"],
      }
    ],
    tagOwners = {
      "${local.relay_tag}" = ["autogroup:members"]
    },
    autoApprovers = {
      routes = {
        "${aws_vpc.this.cidr_block}" = ["${local.relay_tag}"]
      }
    }
  })
}
