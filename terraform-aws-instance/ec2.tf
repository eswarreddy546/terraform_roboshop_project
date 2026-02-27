resource "aws_instance" "type" {
    ami = var.ami
    instance_type = var.type

    vpc_security_group_ids = var.group
  tags = var.tags
}



