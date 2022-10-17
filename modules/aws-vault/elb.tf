moved {
  from = aws_lb.vault_lb
  to   = aws_lb.vault
}

resource "aws_lb" "vault" {
  name                       = "${var.resource_name_prefix}-vault-lb"
  internal                   = true
  load_balancer_type         = "application"
  subnets                    = var.lb_subnet_ids
  security_groups            = [aws_security_group.vault_lb.id]
  drop_invalid_header_fields = true
}

resource "aws_lb_target_group" "vault" {
  name        = "${var.resource_name_prefix}-vault-tg"
  target_type = "instance"
  port        = 8200
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    protocol            = "HTTPS"
    port                = "traffic-port"
    path                = "/v1/sys/health?activecode=200&standbycode=200&sealedcode=200&uninitcode=200"
    interval            = 30
  }
}

resource "aws_lb_listener" "vault" {
  load_balancer_arn = aws_lb.vault.id
  port              = 8200
  protocol          = "HTTPS"

  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies
  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = var.lb_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vault.arn
  }
}

resource "aws_route53_record" "vault_lb" {
  zone_id = var.hosted_zone_id
  name    = var.fqdn
  type    = "A"

  alias {
    name    = aws_lb.vault.dns_name
    zone_id = aws_lb.vault.zone_id

    # When set to true, if either none of the ELB's EC2 instances are healthy
    # or the ELB itself is unhealthy, Route 53 routes queries to "other
    # resources." But since we haven't defined any other resources, we'd rather
    # avoid any latency due to switchovers and just wait for the ELB and Vault
    # instances to come back online.  For more info, see
    # http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-values-alias.html#rrsets-values-alias-evaluate-target-health
    evaluate_target_health = false
  }
}
