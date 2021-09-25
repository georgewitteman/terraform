resource "dnsimple_record" "cname" {
  domain = var.domain
  name   = var.subdomain
  type   = "CNAME"
  ttl    = var.ttl

  value = "404.al"
}
