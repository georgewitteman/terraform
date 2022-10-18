data "dns_a_record_set" "github_pages" {
  host = var.gh_pages_url
}

resource "aws_route53_record" "this" {
  for_each = toset(["", "www"])

  zone_id = var.zone_id
  name    = each.key
  type    = "A"
  ttl     = var.ttl
  records = data.dns_a_record_set.github_pages.addrs
}
