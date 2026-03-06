data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project_name}/${var.environment}/mongodb_security_group_id"
}


data "aws_ssm_parameter" "database_subnetsg" {
  name = "/${var.project_name}/${var.environment}/database_subnetsg"
}