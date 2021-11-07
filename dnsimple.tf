module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=quarantine; aspf=s; adkim=s; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com"
}

module "dnsimple_fastmail_witteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.me"
  dmarc  = "v=DMARC1; p=quarantine; aspf=s; adkim=s; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com"
}

module "dnsimple_fastmail_wtmn_net" {
  source = "./modules/dnsimple-fastmail"
  domain = "wtmn.net"
  dmarc  = "v=DMARC1; p=quarantine; aspf=s; adkim=s; pct=100; rua=mailto:re+lcidla2subz@dmarc.postmarkapp.com"
}

module "dnsimple_fastmail_maildrip_net" {
  source = "./modules/dnsimple-fastmail"
  domain = "maildrip.net"
  dmarc  = "v=DMARC1; p=quarantine; aspf=s; adkim=s; pct=100; rua=mailto:re+vinvgvmggle@dmarc.postmarkapp.com"
}

resource "dnsimple_zone_record" "google_postmaster_verification_georgewitteman_com" {
  zone_name = "georgewitteman.com"
  name      = ""
  type      = "TXT"
  ttl       = 3600
  value     = "google-site-verification=n-eQPTxgyqAyfJDuPf4xRrL9zZUSGyhZ_PG6wrp7Lic"
}

resource "dnsimple_zone_record" "home_wtmn_net" {
  zone_name = "wtmn.net"
  name      = "home"
  type      = "ALIAS"
  ttl       = 240
  value     = "georgewitteman.synology.me"
}

resource "dnsimple_zone_record" "google_postmaster_verification" {
  zone_name = "witteman.me"
  name      = ""
  type      = "TXT"
  ttl       = 3600
  value     = "google-site-verification=NW7ujmNyY-X8v_VOlYzD3CJGqDD8dsoG8RTgGPMNKtk"
}

resource "dnsimple_zone_record" "synology_nas" {
  zone_name = "witteman.me"
  name      = "home"
  type      = "ALIAS"
  ttl       = 240
  value     = "georgewitteman.synology.me"
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