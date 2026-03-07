locals {
  catalogue_security_group_id=data.aws_ssm_parameter.catalogue_security_group_id.value
  private_subnetsg =split("," , data.aws_ssm_parameter.private_subnetsg.value)[0]
  vpc_id = data.aws_ssm_parameter.vpc_id.value

}