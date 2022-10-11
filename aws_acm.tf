module "acm_witteman_test_com" {
  source = "./modules/aws-certificate"

  zone_id = aws_route53_zone.witteman_me.zone_id
}
