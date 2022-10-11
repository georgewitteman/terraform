resource "aws_secretsmanager_secret" "tls" {
  name        = "${var.resource_name_prefix}-tls-secret"
  description = "contains TLS certs and private keys"
  kms_key_id  = aws_kms_key.this.id
}

resource "aws_secretsmanager_secret_version" "tls" {
  secret_id     = aws_secretsmanager_secret.tls.id
  secret_string = local.vault_tls_data
}
