locals {
    backend_alb_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    mongodb_security_group_id=data.aws_ssm_parameter.mongodb_security_group_id.value
    reddis_security_group_id = data.aws_ssm_parameter.reddis_security_group_id.value
    rabbitmq_security_group_id = data.aws_ssm_parameter.rabbitmq_security_group_id.value
    mysql_security_group_id=data.aws_ssm_parameter.mysql_security_group_id.value
    catalogue_security_group_id = data.aws_ssm_parameter.catalogue_security_group_id.value
}