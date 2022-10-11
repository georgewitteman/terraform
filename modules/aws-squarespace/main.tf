locals {
  ips = ["198.185.159.144", "198.185.159.145", "198.49.23.144", "198.49.23.145"]
}

resource "aws_route53_record" "verify_cname" {
  zone_id = var.zone_id

  name    = var.verify_cname
  type    = "CNAME"
  ttl     = var.ttl
  records = ["verify.squarespace.com"]
}

resource "aws_route53_record" "www_cname" {
  zone_id = var.zone_id

  name    = "www"
  type    = "CNAME"
  ttl     = var.ttl
  records = ["ext-cust.squarespace.com"]
}

resource "aws_route53_record" "a" {
  zone_id = var.zone_id

  name    = ""
  type    = "A"
  ttl     = var.ttl
  records = local.ips
}
