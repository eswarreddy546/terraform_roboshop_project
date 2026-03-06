locals {
  mongodb_sg_id= data.aws_ssm_parameter.mongodb_sg_id.value
  database_subnetsg = split("," , data.aws_ssm_parameter.database_subnetsg.value)[0]

}