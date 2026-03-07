############################################
# Fetch values from SSM
############################################

data "aws_ssm_parameter" "private_subnetsg" {
  name = "/${var.project_name}/${var.environment}/private_subnetsg"
}

data "aws_ssm_parameter" "catalogue_security_group_id" {
  name = "/${var.project_name}/${var.environment}/catalogue_security_group_id"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "backend_alb_arn_listiner" {
  name = "/${var.project_name}/${var.environment}/backend_alb_arn_listiner"
}