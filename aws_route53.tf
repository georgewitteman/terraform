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

resource "aws_route53_zone" "marcywitteman_com" {
  name = "marcywitteman.com"
}

module "aws_fastmail_georgewitteman_com" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.georgewitteman_com.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "aws_fastmail_georgewitteman_me" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.georgewitteman_me.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+zcrwq1j87mr@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "aws_fastmail_witteman_me" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.witteman_me.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "aws_fastmail_wtmn_net" {
  source  = "./modules/aws-fastmail"
  zone_id = aws_route53_zone.wtmn_net.zone_id
  dmarc   = "v=DMARC1; p=reject; pct=100; rua=mailto:re+lcidla2subz@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "aws_squarespace_marcywitteman_com" {
  source       = "./modules/aws-squarespace"
  zone_id      = aws_route53_zone.marcywitteman_com.zone_id
  verify_cname = "ygcg8lysbebsftxsez6l"
}

resource "aws_route53_record" "google_workspace_verification" {
  zone_id = aws_route53_zone.witteman_me.zone_id
  name    = ""
  type    = "TXT"
  records = ["google-site-verification=Dgy7CxrBlRf1Ucs5YonfE2m99jkPGh2RUl7BrV7EoD0"]
}
