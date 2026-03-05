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

#redis ingress and egress

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