resource "aws_instance" "catalogue" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_security_group_id]
  subnet_id              = local.private_subnetsg
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  # terraform copies this file to mongodb server
  provisioner "file" {
    source = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/catalogue.sh",
        # "sudo sh /tmp/catalogue.sh"
        "sudo sh /tmp/catalogue.sh catalogue"
    ]
  }
}
