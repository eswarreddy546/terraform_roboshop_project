resource "aws_instance" "first" {
    ami = ""
    instance_type = ""
  
  tags = {
    name= "dev"
  }
}
