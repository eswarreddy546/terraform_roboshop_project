resource "aws_lb" "frontend_alb" {
  name               = "front_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_security_group_id.id]
  subnets = local.public_subnetsg
  enable_deletion_protection = true

 

  tags = {
    Environment = "alb_production"
  }
}

# Create a Target Group (TG)
# resource "aws_lb_target_group" "example_tg" {
#   name     = "backend-tg-tf"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = local.vpc_id.id

#   health_check {
#     path = "/"
#     port = "traffic-port"
#     protocol = "HTTP"
#   }
# }

# Create the ALB Listener # Backend ALB listening on port number 80
resource "aws_lb_listener" "frontend_https_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.roboshop.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

# resource "aws_route53_record" "loadbalncerrecord" {
#   zone_id = var.zoneid
#   name    = "*.backend-dev.eswar.xyz"
#   type    = "A"

#   alias {
#     name                   = aws_lb.backendalb.dns_name
#     zone_id                = aws_lb.backendalb.zone_id
#     evaluate_target_health = true
#   }
# }