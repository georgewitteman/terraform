resource "aws_route53domains_registered_domain" "witteman_test_com" {
  domain_name = aws_route53_zone.witteman_test_com.name
}

resource "aws_route53_zone" "witteman_test_com" {
  name = "witteman-test.com"
}

resource "aws_route53_zone" "georgewitteman_com" {
  name = "georgewitteman.com"
}

resource "aws_route53_zone" "georgewitteman_me" {
  name = "georgewitteman.me"
}

resource "aws_route53_zone" "witteman_me" {
  name = "witteman.me"
}

resource "aws_route53_zone" "wtmn_net" {
  name = "wtmn.net"
}

resource "aws_route53_zone" "wtmn_link" {
  name = "wtmn.link"
}

resource "aws_route53_zone" "marcywitteman_com" {
  name = "marcywitteman.com"
}

locals {
  spf = "v=spf1 include:spf.messagingengine.com -all"
}

module "aws_fastmail_georgewitteman_com" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.georgewitteman_com.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

resource "aws_route53_record" "georgewitteman_com_txt" {
  zone_id = aws_route53_zone.georgewitteman_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 60 * 5
  records = [local.spf]
}

module "aws_github_pages_georgewitteman_com" {
  source       = "./modules/aws-github-pages"
  zone_id      = aws_route53_zone.georgewitteman_com.zone_id
  gh_pages_url = "georgewitteman.github.io"
}

module "aws_fastmail_georgewitteman_me" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.georgewitteman_me.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+zcrwq1j87mr@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

resource "aws_route53_record" "georgewitteman_me_txt" {
  zone_id = aws_route53_zone.georgewitteman_me.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 60 * 5
  records = [local.spf]
}

module "aws_fastmail_witteman_me" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.witteman_me.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

resource "aws_route53_record" "witteman_me_txt" {
  zone_id = aws_route53_zone.witteman_me.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 60 * 5
  records = [
    local.spf,
    "google-site-verification=Dgy7CxrBlRf1Ucs5YonfE2m99jkPGh2RUl7BrV7EoD0",
  ]
}

module "aws_fastmail_wtmn_net" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.wtmn_net.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+lcidla2subz@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

resource "aws_route53_record" "wtmn_net_txt" {
  zone_id = aws_route53_zone.wtmn_net.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 60 * 5
  records = [local.spf]
}

module "aws_squarespace_marcywitteman_com" {
  source       = "./modules/aws-squarespace"
  zone_id      = aws_route53_zone.marcywitteman_com.zone_id
  verify_cname = "ygcg8lysbebsftxsez6l"
}

module "aws_short_io_wtmn_link" {
  source  = "./modules/aws-short-io"
  zone_id = aws_route53_zone.wtmn_link.zone_id
}
