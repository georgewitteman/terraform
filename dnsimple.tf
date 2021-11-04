module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com,mailto:dmarc+rua@witteman.me; ruf=mailto:dmarc+ruf@witteman.me; fo=1:d:s"
}

resource "dnsimple_zone_record" "google_postmaster_verification_georgewitteman_com" {
  zone_name = "georgewitteman.com"
  name      = ""
  type      = "TXT"
  ttl       = 3600
  value     = "google-site-verification=n-eQPTxgyqAyfJDuPf4xRrL9zZUSGyhZ_PG6wrp7Lic"
}

module "dnsimple_fastmail_wtmn_net" {
  source = "./modules/dnsimple-fastmail"
  domain = "wtmn.net"
  dmarc  = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+lcidla2subz@dmarc.postmarkapp.com,mailto:dmarc+rua@witteman.me; ruf=mailto:dmarc+ruf@witteman.me; fo=1:d:s"
}

module "dnsimple_fastmail_witteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.me"
  dmarc  = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com,mailto:dmarc+rua@witteman.me; ruf=mailto:dmarc+ruf@witteman.me; fo=1:d:s"
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
  ttl       = 3600
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