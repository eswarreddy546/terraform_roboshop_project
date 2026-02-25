resource "aws_instance" "type" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t2.small"

    vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  


    provisioner "local-exec"{
      command = "echo ${self.private_ip} > inventory"
      on_failure = continue
    }

    provisioner "local-exec"{
      command = "echo Instance is destroyed"
      when    = destroy
    }

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