resource "aws_secretsmanager_secret" "authkey" {
  name        = "${var.resource_name_prefix}-tailscale-relay-authkey"
  description = "Tailscale pre-authorization key for the tailscale relay"
  kms_key_id  = aws_kms_key.this.id
}

resource "aws_secretsmanager_secret_version" "authkey" {
  secret_id     = aws_secretsmanager_secret.authkey.id
  secret_string = var.authkey
}
