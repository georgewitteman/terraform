locals {
  dkim_hosts = ["fm1", "fm2", "fm3"]
}

data "aws_route53_zone" "selected" {
  zone_id = var.zone_id
}

data "dns_a_record_set" "mail" {
  host = "mail.fastmail.com"
}

resource "aws_route53_record" "mail" {
  zone_id = var.zone_id

  name    = "mail"
  type    = "A"
  ttl     = var.ttl
  records = data.dns_a_record_set.mail.addrs
}

resource "aws_route53_record" "mx" {
  zone_id = var.zone_id

  name    = ""
  type    = "MX"
  ttl     = var.ttl
  records = ["10 in1-smtp.messagingengine.com", "20 in2-smtp.messagingengine.com"]
}

resource "aws_route53_record" "spf" {
  zone_id = var.zone_id

  name    = ""
  type    = "TXT"
  ttl     = var.ttl
  records = ["v=spf1 include:spf.messagingengine.com -all"]
}

resource "aws_route53_record" "dkim" {
  for_each = toset(local.dkim_hosts)

  zone_id = var.zone_id
  name    = "${each.key}._domainkey"
  type    = "CNAME"
  ttl     = var.ttl
  records = ["${each.key}.${data.aws_route53_zone.selected.name}.dkim.fmhosted.com"]
}

resource "aws_route53_record" "dmarc" {
  count = var.dmarc == "" ? 0 : 1

  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = var.ttl
  records = [var.dmarc]
}

resource "aws_route53_record" "srv_submission" {
  zone_id = var.zone_id

  name    = "_submission._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 1 587 smtp.fastmail.com"]
}

resource "aws_route53_record" "srv_imap" {
  zone_id = var.zone_id

  name    = "_imap._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "srv_imaps" {
  zone_id = var.zone_id

  name    = "_imaps._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 1 993 imap.fastmail.com"]
}

resource "aws_route53_record" "srv_pop3" {
  zone_id = var.zone_id

  name    = "_pop3._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "srv_pop3s" {
  zone_id = var.zone_id

  name    = "_pop3s._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["10 1 995 pop.fastmail.com"]
}

resource "aws_route53_record" "srv_jmap" {
  zone_id = var.zone_id

  name    = "_jmap._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 1 443 api.fastmail.com"]
}

resource "aws_route53_record" "srv_carddav" {
  zone_id = var.zone_id

  name    = "_carddav._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "srv_carddavs" {
  zone_id = var.zone_id

  name    = "_carddavs._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 1 443 carddav.fastmail.com"]
}

resource "aws_route53_record" "srv_caldav" {
  zone_id = var.zone_id

  name    = "_caldav._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "srv_caldavs" {
  zone_id = var.zone_id

  name    = "_caldavs._tcp"
  type    = "SRV"
  ttl     = var.ttl
  records = ["0 1 443 caldav.fastmail.com"]
}
