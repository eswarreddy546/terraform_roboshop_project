locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  frontend_alb_security_group_id = split(",", data.aws_ssm_parameter.frontend_alb_security_group_id.value)
   
 public_subnetsg = split(",", data.aws_ssm_parameter.public_subnetsg.value)

}