output "public_ip" {
    value = aws_instance.type.public_ip
  
}
output "private_ip" {
    value = aws_instance.type.private_ip
  
}

output "instanceid" {
  value = aws_instance.type.id
}