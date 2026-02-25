resource "aws_instance" "type" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t2.small"

    vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  
}

resource "aws_security_group" "allow_all" {

  dynamic "ingress" {
  for_each = toset(var.ports)
  content {
    protocol    = "tcp"
    from_port   = ingress.value
    to_port     = ingress.value
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}