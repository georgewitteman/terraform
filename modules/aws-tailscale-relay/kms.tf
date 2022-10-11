resource "aws_kms_key" "this" {
  description         = "AWS KMS Customer-managed key used for Vault auto-unseal and encryption"
  enable_key_rotation = true
  is_enabled          = true
  key_usage           = "ENCRYPT_DECRYPT"
}
