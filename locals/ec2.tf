resource "aws_instance" "type" {
    ami = local.ami_id
    instance_type = local.instance_type

    vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  
  tags = local.tags
}



resource "aws_security_group" "allow_all" {

  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}