provider "dnsimple" {
  token   = var.dnsimple_token
  account = var.dnsimple_account
}

module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=reject; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "dnsimple_fastmail_georgewitteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.me"
  dmarc  = "v=DMARC1; p=reject; pct=100; rua=mailto:re+zcrwq1j87mr@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "dnsimple_fastmail_witteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.me"
  dmarc  = "v=DMARC1; p=reject; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "dnsimple_fastmail_wtmn_net" {
  source = "./modules/dnsimple-fastmail"
  domain = "wtmn.net"
  dmarc  = "v=DMARC1; p=reject; pct=100; rua=mailto:re+lcidla2subz@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

resource "dnsimple_zone_record" "files_wtmn_net_alias" {
  zone_name = "wtmn.net"
  name      = "files"
  type      = "ALIAS"
  ttl       = 300

  value = "web.messagingengine.com"
}

resource "dnsimple_zone_record" "github_redirect" {
  zone_name = "witteman.me"
  name      = "www"
  type      = "URL"
  ttl       = 300
  value     = "https://github.com/georgewitteman"
}

module "dnsimple_github_pages" {
  source       = "./modules/dnsimple-github-pages"
  domain       = "georgewitteman.com"
  gh_pages_url = "georgewitteman.github.io"
}

module "dnsimple_short_io" {
  source = "./modules/dnsimple-short-io"
  domain = "wtmn.link"
}

module "dnsimple_squarespace_marcywitteman_com" {
  source       = "./modules/dnsimple-squarespace"
  domain       = "marcywitteman.com"
  verify_cname = "ygcg8lysbebsftxsez6l"
}

resource "dnsimple_zone_record" "google_workspace_verification" {
  zone_name = "witteman.me"
  name      = ""
  type      = "TXT"
  value     = "google-site-verification=Dgy7CxrBlRf1Ucs5YonfE2m99jkPGh2RUl7BrV7EoD0"
}
