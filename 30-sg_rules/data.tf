data "aws_ssm_parameter" "frontend_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/frontend_alb_security_group_id"
}

data "aws_ssm_parameter" "backend_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/backend_alb_security_group_id"
}

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project_name}/${var.environment}/bastionhost_security_group_id"
}

data "aws_ssm_parameter" "mongodb_security_group_id" {
  name = "/${var.project_name}/${var.environment}/mongodb_security_group_id"
}

data "aws_ssm_parameter" "reddis_security_group_id" {
  name = "/${var.project_name}/${var.environment}/reddis_security_group_id"
}

data "aws_ssm_parameter" "rabbitmq_security_group_id" {
  name = "/${var.project_name}/${var.environment}/rabbitmq_security_group_id"
}

data "aws_ssm_parameter" "mysql_security_group_id" {
  name = "/${var.project_name}/${var.environment}/mysql_security_group_id"
}

data "aws_ssm_parameter" "catalogue_security_group_id" {
  name = "/${var.project_name}/${var.environment}/catalogue_security_group_id"
}