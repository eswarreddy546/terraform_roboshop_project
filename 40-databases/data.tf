# data "aws_ami" "amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project_name}/${var.environment}/mongodb_security_group_id"
}


data "aws_ssm_parameter" "database_subnetsg" {
  name = "/${var.project_name}/${var.environment}/database_subnetsg"
}

data "aws_ssm_parameter" "reddis_security_group_id" {
  name = "/${var.project_name}/${var.environment}/reddis_security_group_id"
}
