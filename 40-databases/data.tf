data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project_name}/${var.environment}/mongodb_security_group_id"
}


data "aws_ssm_parameter" "database_subnetsg" {
  name = "/${var.project_name}/${var.environment}/database_subnetsg"
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