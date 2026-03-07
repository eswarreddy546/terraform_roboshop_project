resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  
}


resource "aws_security_group_rule" "mongodb" {
  type              = "ingress"
  security_group_id = local.mongodb_security_group_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  
}
resource "aws_security_group_rule" "mongodb_egress" {
  type              = "egress"
  security_group_id = local.mongodb_security_group_id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# redis ingress and egress

resource "aws_security_group_rule" "redis" {
  type              = "ingress"
  security_group_id = local.reddis_security_group_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  
}

resource "aws_security_group_rule" "redis_egress" {
  type              = "egress"
  security_group_id = local.reddis_security_group_id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

#rabbitmq ingress and egress


resource "aws_security_group_rule" "rabbitmq" {
  type              = "ingress"
  security_group_id = local.reddis_security_group_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  
}

resource "aws_security_group_rule" "r_egress" {
  type              = "egress"
  security_group_id = local.reddis_security_group_id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mysql" {
  type              = "ingress"
  security_group_id = local.mysql_security_group_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  
}

resource "aws_security_group_rule" "mysql_egress" {
  type              = "egress"
  security_group_id = local.mysql_security_group_id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


#catalogue

resource "aws_security_group_rule" "catalogue" {
  type              = "ingress"
  security_group_id = local.catalogue_security_group_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  
}

resource "aws_security_group_rule" "catalogue_egress" {
  type              = "egress"
  security_group_id = local.mysql_security_group_id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  security_group_id = local.mongodb_security_group_id
  source_security_group_id = local.mongodb_security_group_id
  from_port         = 27017
  protocol          = "tcp"
  to_port           = 27017
}

resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  security_group_id = local.catalogue_security_group_id
  source_security_group_id = local.backend_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}



resource "aws_security_group_rule" "frontend_alb" {
  type              = "ingress"
  security_group_id = local.frontend_alb_sg_id
  source_security_group_id = local.backend_alb_sg_id
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}


resource "aws_security_group_rule" "frontend_egress" {
  type              = "egress"
  security_group_id = local.frontend_alb_sg_id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

