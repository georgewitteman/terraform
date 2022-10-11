module "vault" {
  source = "./modules/aws-vault"

  fqdn                 = "vault.${aws_route53_zone.witteman_test_com.name}"
  resource_name_prefix = "main"
  vpc_id               = aws_vpc.this.id
  lb_certificate_arn   = aws_acm_certificate.vault.arn
  lb_subnet_ids        = aws_subnet.private[*].id
  vault_subnet_ids     = aws_subnet.private[*].id
  ssh_key_name         = aws_key_pair.georgewitteman.key_name
}

resource "aws_route53_record" "vault" {
  zone_id = aws_route53_zone.witteman_test_com.zone_id
  name    = "vault"
  type    = "CNAME"
  ttl     = 60
  records = [module.vault.lb_dns_name]
}
