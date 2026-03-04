locals {
    backend_alb_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    mongodb_security_group_id=data.aws_ssm_parameter.mongodb_security_group_id.value


}