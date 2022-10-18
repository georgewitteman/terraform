resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = ""
  type    = "A"
  ttl     = var.ttl
  records = ["52.21.33.16", "52.2.56.64"]
}
