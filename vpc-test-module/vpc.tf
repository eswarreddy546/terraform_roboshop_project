module "vpc_main" {
  source       = "../vpc-module"
  mycidr = var.cidr_blocks
  project_tag = var.project_tags
  environment  = var.environment
  igw = var.igw
  publicsubnet = var.publicsubnet
  privatesubnet = var.privatesubnet
  privatedatabasesubnet = var.privatedatabasesubnet
  publicrt = var.publicrt
  privatert = var.privatert
  privatedatabasert = var.privatedatabasert
  route = var.route
peering_is_required= false  
  

}

# data "aws_availability_zones" "az" {
#   state = "available"
# }