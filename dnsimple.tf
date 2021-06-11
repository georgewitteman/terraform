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

module "dnsimple_fastmail_witteman_email" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.email"
  dmarc  = "v=DMARC1; p=none; pct=100; rua=mailto:re+nc4kkbmbvko@dmarc.postmarkapp.com; sp=none; aspf=r;"
}

module "dnsimple_fastmail_witteman_family" {
  source = "./modules/dnsimple-fastmail"
  domain = "witteman.family"
  dmarc  = "v=DMARC1; p=none; pct=100; rua=mailto:re+yyvpwlplj2n@dmarc.postmarkapp.com; sp=none; aspf=r;"
}

module "dnsimple_fastmail_wtmn_net" {
  source = "./modules/dnsimple-fastmail"
  domain = "wtmn.net"
}

module "dnsimple_github_pages" {
  source       = "./modules/dnsimple-github-pages"
  domain       = "georgewitteman.com"
  gh_pages_url = "georgewitteman.github.io"
}
