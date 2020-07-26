provider "dnsimple" {
  version = "~> 0.4"
}

module "dnsimple_fastmail_georgewitteman_com" {
  source = "./modules/dnsimple-fastmail"
  domain = "georgewitteman.com"
  dmarc  = "v=DMARC1; p=none; pct=100; rua=mailto:re+uimzzzgugvk@dmarc.postmarkapp.com; sp=none; aspf=r;"
}

module "dnsimple_fastmail_witteman_me" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.me"
  dmarc  = "v=DMARC1; p=none; pct=100; rua=mailto:re+igrne0h0z9h@dmarc.postmarkapp.com; sp=none; aspf=r;"
}
