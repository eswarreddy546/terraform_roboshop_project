locals {
  common_name = "${var.project}-${var.enviroment}"

  common_tags = {
    project   = var.project
    terraform = "true"
  }
}