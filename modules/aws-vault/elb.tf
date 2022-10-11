resource "aws_lb" "vault_lb" {
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
  load_balancer_arn = aws_lb.vault_lb.id
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
