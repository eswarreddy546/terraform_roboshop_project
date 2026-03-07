############################################
# Temporary EC2 Instance
############################################

resource "aws_instance" "catalogue" {

  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = "t3.micro"

  vpc_security_group_ids = [local.catalogue_security_group_id]
  subnet_id              = local.private_subnetsg[0]

  tags = {
    Name = "${var.project_name}-${var.environment}-catalogue"
  }
}

############################################
# Provision Catalogue Setup
############################################

resource "terraform_data" "catalogue" {

  triggers_replace = [
    aws_instance.catalogue.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}

############################################
# Stop Instance
############################################

resource "aws_ec2_instance_state" "stop_instance" {

  instance_id = aws_instance.catalogue.id
  state       = "stopped"

  depends_on = [
    terraform_data.catalogue
  ]
}

############################################
# Create AMI
############################################

resource "aws_ami_from_instance" "catalogue" {

  name               = "${var.project_name}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id

  depends_on = [
    aws_ec2_instance_state.stop_instance
  ]
}

############################################
# Target Group
############################################

resource "aws_lb_target_group" "catalogue" {

  name     = "${var.project_name}-${var.environment}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id

  deregistration_delay = 120

  health_check {
    healthy_threshold   = 2
    interval            = 5
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    timeout             = 2
    unhealthy_threshold = 3
  }
}

############################################
# Launch Template
############################################

resource "aws_launch_template" "catalogue" {

  name = "${var.project_name}-${var.environment}-catalogue"

  image_id      = aws_ami_from_instance.catalogue.id
  instance_type = "t3.micro"

  instance_initiated_shutdown_behavior = "terminate"

  vpc_security_group_ids = [
    local.catalogue_security_group_id
  ]

  update_default_version = true

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-catalogue"
    }
  }
}

############################################
# Auto Scaling Group
############################################

resource "aws_autoscaling_group" "catalogue" {

  name = "${var.project_name}-${var.environment}-catalogue"

  desired_capacity = 1
  max_size         = 10
  min_size         = 1

  vpc_zone_identifier = local.private_subnetsg

  target_group_arns = [
    aws_lb_target_group.catalogue.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 90

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  force_delete = true

  timeouts {
    delete = "15m"
  }
}

############################################
# Auto Scaling Policy
############################################

resource "aws_autoscaling_policy" "catalogue" {

  name                   = "${var.project_name}-${var.environment}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }
}
resource "aws_lb_listener_rule" "catalogue" {
 listener_arn = local.backend_alb_arn_listiner
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-${var.environment}.${var.domain_name}"]
    }
  }
}