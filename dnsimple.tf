module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=quarantine; aspf=s; adkim=s; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "dnsimple_fastmail_witteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.me"
  dmarc  = "v=DMARC1; p=quarantine; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
}

module "dnsimple_fastmail_wtmn_net" {
  source = "./modules/dnsimple-fastmail"
  domain = "wtmn.net"
  dmarc  = "v=DMARC1; p=reject; aspf=s; adkim=s; pct=100; rua=mailto:re+lcidla2subz@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email; ruf=mailto:george@witteman.me;"
}

module "dnsimple_fastmail_georgewitteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.me"
  dmarc  = "v=DMARC1; p=quarantine; aspf=s; adkim=s; pct=100; rua=mailto:re+zcrwq1j87mr@dmarc.postmarkapp.com,mailto:dmarc_agg@vali.email;"
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

resource "dnsimple_zone_record" "files_wtmn_net_alias" {
  zone_name = "wtmn.net"
  name      = "files"
  type      = "ALIAS"
  ttl       = 300

  value = "web.messagingengine.com"
}

resource "dnsimple_zone_record" "pm_bounces_witteman_me" {
  zone_name = "witteman.me"
  name      = "pm-bounces"
  type      = "CNAME"
  ttl       = 300
  value     = "pm.mtasv.net"
}

resource "dnsimple_zone_record" "postmark_domainkey_witteman_me" {
  zone_name = "witteman.me"
  name      = "20211105042214pm._domainkey"
  type      = "TXT"
  ttl       = 300
  value     = "k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCGVI8eV/hxWB+9Trd73YIdscUfRoTdQr8Tt5pBKVDgDVUqhHyq8vlVpB1m5jKDAF4gNLCC9LC1Cjrpy3uOrCoDSN9o+dBWI2EWnHd8w4+Kbux6UQOlIsjfQvurIhoVvieNPzpVIuDs3KMYNOrUnjXgu9/se/PrbZIVt0MhIOsE3QIDAQAB"
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

module "dnsimple_short_io" {
  source = "./modules/dnsimple-short-io"
  domain = "wtmn.link"
}

resource "dnsimple_zone_record" "wtmn_email_redirect" {
  zone_name = "wtmn.email"
  name      = ""
  type      = "URL"
  ttl       = 300
  value     = "https://www.fastmail.com/mail/Inbox/?u=3a3140dd"
}

resource "dnsimple_zone_record" "witteman_email_redirect" {
  zone_name = "witteman.email"
  name      = ""
  type      = "URL"
  ttl       = 300
  value     = "https://www.fastmail.com/mail/Inbox/?u=3a3140dd"
}

resource "dnsimple_zone_record" "synology_help_redirect" {
  zone_name = "synology.help"
  name      = ""
  type      = "URL"
  ttl       = 300
  value     = "https://kb.synology.com/en-us"
}

resource "dnsimple_zone_record" "culturedcode_help_redirect" {
  zone_name = "culturedcode.help"
  name      = ""
  type      = "URL"
  ttl       = 300
  value     = "https://culturedcode.com/things/support/"
}

resource "dnsimple_zone_record" "culturedcode_blog_redirect" {
  zone_name = "culturedcode.blog"
  name      = ""
  type      = "URL"
  ttl       = 300
  value     = "https://culturedcode.com/things/blog/"
}

module "dnsimple_squarespace_marcywitteman_com" {
  source       = "./modules/dnsimple-squarespace"
  domain       = "marcywitteman.com"
  verify_cname = "ygcg8lysbebsftxsez6l"
}
