provider "tailscale" {}

resource "tailscale_tailnet_key" "aws_relay" {
  reusable      = true
  ephemeral     = true
  preauthorized = true
}

module "tailscale_relay" {
  source = "./modules/aws-tailscale-relay"

  vpc_id               = aws_vpc.this.id
  authkey              = tailscale_tailnet_key.aws_relay.key
  resource_name_prefix = "main"
  public_subnet_ids    = aws_subnet.public[*].id
  ssh_key_name         = aws_key_pair.georgewitteman.key_name
}
