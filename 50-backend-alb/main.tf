resource "aws_lb" "backendalb" {
  name               = "backendalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.bastionhost_security_group_id]
subnets = local.private_subnetsg
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

# Create the ALB Listener
resource "aws_lb_listener" "loabalbbackendlistiner" {
  load_balancer_arn = aws_lb.backendalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_route53_record" "loadbalncerrecord" {
  zone_id = var.zoneid
  name    = "*.backend-dev.eswar.xyz"
  type    = "A"

  alias {
    name                   = aws_lb.backendalb.dns_name
    zone_id                = aws_lb.backendalb.zone_id
    evaluate_target_health = true
  }
}