locals {
  dkim_hosts = ["fm1", "fm2", "fm3"]
  mx_hosts   = [""]
  # mx_hosts   = ["", "*", "mail"]
}

resource "dnsimple_zone_record" "a" {
  count     = var.a_records == "true" ? 1 : 0
  zone_name = var.domain
  name      = ""
  type      = "ALIAS"
  ttl       = var.ttl

  value = "web.messagingengine.com"
}

resource "dnsimple_zone_record" "a_wildcard" {
  count     = var.a_records == "true" ? 1 : 0
  zone_name = var.domain
  name      = "*"
  type      = "ALIAS"
  ttl       = var.ttl

  value = "web.messagingengine.com"
}

resource "dnsimple_zone_record" "mail" {
  zone_name = var.domain
  name      = "mail"
  type      = "ALIAS"
  ttl       = var.ttl

  value = "mail.fastmail.com"
}

resource "dnsimple_zone_record" "mx_10" {
  count = length(local.mx_hosts)

  zone_name = var.domain
  name      = element(local.mx_hosts, count.index)
  type      = "MX"
  ttl       = var.ttl
  priority  = "10"

  value = "in1-smtp.messagingengine.com"
}

resource "dnsimple_zone_record" "mx_20" {
  count = length(local.mx_hosts)

  zone_name = var.domain
  name      = element(local.mx_hosts, count.index)
  type      = "MX"
  ttl       = var.ttl
  priority  = "20"

  value = "in2-smtp.messagingengine.com"
}

resource "dnsimple_zone_record" "spf" {
  zone_name = var.domain
  name      = ""
  type      = "TXT"
  ttl       = var.ttl

  value = "v=spf1 include:spf.messagingengine.com -all"
}

resource "dnsimple_zone_record" "dkim" {
  count = length(local.dkim_hosts)

  zone_name = var.domain
  name      = "${element(local.dkim_hosts, count.index)}._domainkey"
  type      = "CNAME"
  ttl       = var.ttl

  value = "${element(local.dkim_hosts, count.index)}.${var.domain}.dkim.fmhosted.com"
}

resource "dnsimple_zone_record" "dmarc" {
  count     = var.dmarc == "" ? 0 : 1
  zone_name = var.domain
  name      = "_dmarc"
  type      = "TXT"
  ttl       = var.ttl

  value = var.dmarc
}

resource "dnsimple_zone_record" "bimi" {
  zone_name = var.domain
  name      = "default._bimi"
  type      = "TXT"
  ttl       = var.ttl

  value = "v=BIMI1; l=https://www.georgewitteman.com/files/bimi-svg-tiny-12-ps.svg;"
}

resource "dnsimple_zone_record" "srv_submission" {
  zone_name = var.domain
  name      = "_submission._tcp"
  type      = "SRV"
  ttl       = var.ttl
  priority  = 0

  value = "1 587 smtp.fastmail.com"
}

resource "dnsimple_zone_record" "srv_imaps" {
  zone_name = var.domain
  name      = "_imaps._tcp"
  type      = "SRV"
  ttl       = var.ttl
  priority  = 0

  value = "1 993 imap.fastmail.com"
}

resource "dnsimple_zone_record" "srv_pop3s" {
  zone_name = var.domain
  name      = "_pop3s._tcp"
  type      = "SRV"
  ttl       = var.ttl
  priority  = 0

  value = "1 995 pop.fastmail.com"
}

resource "dnsimple_zone_record" "srv_jmap" {
  zone_name = var.domain
  name      = "_jmap._tcp"
  type      = "SRV"
  ttl       = var.ttl
  priority  = 0

  value = "1 443 jmap.fastmail.com"
}

resource "dnsimple_zone_record" "srv_carddavs" {
  zone_name = var.domain
  name      = "_carddavs._tcp"
  type      = "SRV"
  ttl       = var.ttl
  priority  = 0

  value = "1 443 carddav.fastmail.com"
}

resource "dnsimple_zone_record" "srv_caldavs" {
  zone_name = var.domain
  name      = "_caldavs._tcp"
  type      = "SRV"
  ttl       = var.ttl
  priority  = 0

  value = "1 443 caldav.fastmail.com"
}
