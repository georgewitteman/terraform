resource "aws_acm_certificate" "vault" {
  domain_name       = "vault.${aws_route53_zone.witteman_test_com.name}"
  validation_method = "DNS"

  lifecycle {
    # Recommended by docs
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_vault" {
  for_each = {
    for dvo in aws_acm_certificate.vault.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.witteman_test_com.id
}

resource "aws_acm_certificate_validation" "vault" {
  certificate_arn         = aws_acm_certificate.vault.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_vault : record.fqdn]
}
