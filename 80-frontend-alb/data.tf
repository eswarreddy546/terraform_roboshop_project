data "aws_ssm_parameter" "public_subnetsg" {
  name = "/${var.project_name}/${var.environment}/public_subnetsg"
}


data "aws_ssm_parameter" "frontend_alb_security_group_id" {
  name  = "/${var.project_name}/${var.environment}/frontend_alb_security_group_id"
}

data "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"
}



