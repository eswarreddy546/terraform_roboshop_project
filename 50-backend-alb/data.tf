data "aws_ssm_parameter" "public_subnetsg" {
  name = "/${var.project_name}/${var.environment}/public_subnetsg"
}

data "aws_ssm_parameter" "bastionhost_security_group_id" {
  name = "/${var.project_name}/${var.environment}/bastionhost_security_group_id"
}

data "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnetsg" {
  name  = "/${var.project_name}/${var.environment}/private_subnetsg"
}

data "aws_ssm_parameter" "mongodb_security_group_id" {
  name = "/${var.project_name}/${var.environment}/mongodb_security_group_id"
}
