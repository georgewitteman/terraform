locals {
  ips = ["198.185.159.144", "198.185.159.145", "198.49.23.144", "198.49.23.145"]
}

resource "dnsimple_zone_record" "verify_cname" {
  zone_name = var.domain
  name      = var.verify_cname
  value     = "verify.squarespace.com"
  type      = "CNAME"
  ttl       = var.ttl
}

resource "dnsimple_zone_record" "www_cname" {
  zone_name = var.domain
  name      = "www"
  value     = "ext-cust.squarespace.com"
  type      = "CNAME"
  ttl       = var.ttl
}

resource "dnsimple_zone_record" "a_records" {
  count = length(local.ips)

  zone_name = var.domain
  name      = ""
  type      = "A"
  ttl       = var.ttl

  value = element(local.ips, count.index)
}
