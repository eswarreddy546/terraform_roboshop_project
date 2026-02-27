module "catalogue" {
  source = "../terraform-aws-instance"

  ami   = var.ami_type
  type  = var.type
  group = var.group
  tags  = var.tags
}


  
output "public_ip" {
  value = module.catalogue.public_ip
}
output "private_ip" {
    value = module.catalogue.private_ip
  
}

output "instance_id" {
  
  value = module.catalogue.instanceid
}