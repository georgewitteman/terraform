module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+kwgr6yysiwt@dmarc.postmarkapp.com,mailto:dmarc+rua@witteman.me; ruf=mailto:dmarc+ruf@witteman.me; fo=1:d:s"
}

module "dnsimple_fastmail_witteman_me" {
  source    = "./modules/dnsimple-fastmail"
  domain    = "witteman.me"
  dmarc     = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+etpsv9gfdep@dmarc.postmarkapp.com,mailto:dmarc+rua@witteman.me; ruf=mailto:dmarc+ruf@witteman.me; fo=1:d:s"
  a_records = "true"
}

module "dnsimple_github_pages" {
  source       = "./modules/dnsimple-github-pages"
  domain       = "georgewitteman.com"
  gh_pages_url = "georgewitteman.github.io"
}