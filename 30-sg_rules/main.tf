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
