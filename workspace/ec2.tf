resource "aws_instance" "type" {
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace)

    vpc_security_group_ids = [ aws_security_group.allow_all.id ]

   tags = merge(
  local.common_tags,
  {
    Name = "${local.common_name}-tfvars-multi-env"
  }
)
  
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