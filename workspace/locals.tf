locals {
    enviroment = lookup(var.enviroment, terraform.workspace) # this is one type you can use this of use below one also
  common_name = "${var.project}-${terraform.workspace}"

  common_tags = {
    project   = var.project
    terraform = "true"
  }
}