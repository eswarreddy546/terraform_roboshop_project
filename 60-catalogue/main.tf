resource "aws_instance" "catalogue" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_security_group_id]
  subnet_id              = local.private_subnetsg

  tags = {
    Name = "${var.project_name}-${var.environment}-catalogue"
  }
}


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

  # copy script to server
  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  # execute script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}


resource "aws_ec2_instance_state" "stop_instance" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ terraform_data.catalogue ]
}

resource "aws_ami_from_instance" "example" {
  name               = "terraform-example-aws-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.stop_instance ]
}

resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project_name}-${var.environment}-catalogue" #roboshop-dev-catalogue
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 120
  health_check {
    healthy_threshold = 2
    interval = 5
    matcher = "200-299"
    path = "/health"
    port = 8080
    timeout = 2
    unhealthy_threshold = 3
  }
}



resource "aws_launch_template" "catalogue" {
  name = "${var.project_name}-${var.environment}-catalogue"

  image_id = "ami-0220d79f3f480ecf5"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_security_group_id]
  update_default_version = true # each time you update, new version will become default
  tag_specifications {
    resource_type = "instance"
    # EC2 tags created by ASG
   
  }
}



resource "aws_autoscaling_group" "catalogue" {
  name                 = "${var.project_name}-${var.environment}-catalogue"

  desired_capacity     = 1
  max_size             = 10
  min_size             = 1

  target_group_arns    = [aws_lb_target_group.catalogue.arn]

vpc_zone_identifier = local.private_subnetsg

  health_check_grace_period = 90
  health_check_type         = "ELB"

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${var.project_name}-${var.environment}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }
}