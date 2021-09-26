resource "dnsimple_zone_record" "alias-record-root" {
  zone_name = var.domain
  name      = ""
  value     = var.gh_pages_url
  type      = "ALIAS"
  ttl       = 60
}

resource "dnsimple_zone_record" "cname-record-www" {
  zone_name = var.domain
  name      = "www"
  value     = var.gh_pages_url
  type      = "CNAME"
  ttl       = 60
}
