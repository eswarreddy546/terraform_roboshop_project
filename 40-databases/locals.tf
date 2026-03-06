locals {
  mongodb_sg_id= data.aws_ssm_parameter.mongodb_sg_id.value
  database_subnetsg = split("," , data.aws_ssm_parameter.database_subnetsg.value)[0]
  reddis_security_group_id = data.aws_ssm_parameter.reddis_security_group_id.value
  rabbitmq_security_group_id=data.aws_ssm_parameter.rabbitmq_security_group_id.value
 mysql_security_group_id= data.aws_ssm_parameter.mysql_security_group_id.value
 
}