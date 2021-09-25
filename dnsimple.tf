module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+uimzzzgugvk@dmarc.postmarkapp.com; ruf=mailto:forensicreports@witteman.me; fo=1:d:s"
}

module "dnsimple_fastmail_witteman_me" {
  source    = "./modules/dnsimple-fastmail"
  domain    = "witteman.me"
  dmarc     = "v=DMARC1; p=quarantine; sp=quarantine; aspf=r; pct=100; rua=mailto:re+igrne0h0z9h@dmarc.postmarkapp.com,mailto:re+1dce928e4bb4@inbound.dmarcdigests.com; ruf=mailto:forensicreports@witteman.me; fo=1:d:s"
  a_records = "true"
}

module "dnsimple_github_pages" {
  source       = "./modules/dnsimple-github-pages"
  domain       = "georgewitteman.com"
  gh_pages_url = "georgewitteman.github.io"
}
