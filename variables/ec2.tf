resource "aws_instance" "type" {
    ami = var.ami
    instance_type = var.instance_type

    vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  
     tags = var.tags
}



resource "aws_security_group" "allow_all" {

  ingress {
    protocol  = var.protocol
    self      = true
    from_port = var.from_port
    to_port   = var.to_port
  }

  egress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }
}