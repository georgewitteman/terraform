resource "dnsimple_zone_record" "a_record_1" {
  zone_name = var.domain
  name      = ""
  value     = "52.21.33.16"
  type      = "A"
  ttl       = var.ttl
}

resource "dnsimple_zone_record" "a_record_2" {
  zone_name = var.domain
  name      = ""
  value     = "52.2.56.64"
  type      = "A"
  ttl       = var.ttl
}
