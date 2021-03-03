resource "dnsimple_record" "alias-record-root" {
  domain = var.domain
  name   = "@"
  value  = var.gh_pages_url
  type   = "ALIAS"
  ttl    = 60
}

resource "dnsimple_record" "cname-record-www" {
  domain = var.domain
  name   = "www"
  value  = var.gh_pages_url
  type   = "CNAME"
  ttl    = 60
}
