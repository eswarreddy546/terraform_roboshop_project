data "aws_instance" "foo" {
  instance_id = "i-0b382d6905474ecc5"

}

output "printing" {
  
  value = data.aws_instance.foo
}