output "vpc_id" {
  value = module.vpc_main.vpc_id
}


# output "az" {
#   value = data.aws_availability_zones.az.names
# }