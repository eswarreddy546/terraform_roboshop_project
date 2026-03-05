data "aws_ssm_parameter" "private_subnetsg" {
  name = "/${var.project_name}/${var.environment}/private_subnetsg"
}


data "aws_ssm_parameter" "catalogue_security_group_id" {
  name = "/${var.project_name}/${var.environment}/catalogue_security_group_id"
}
