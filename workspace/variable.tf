variable "ami" {
  default = "ami-0220d79f3f480ecf5"
}

variable "instance_type" {
    default = {
        dev = "t2.small"
        prod = "t2.micro"
    }
}

variable "project" {
  type    = string
  default = "Roboshop"
}

variable "enviroment" {
default = {
    dev ="dev"
    prod = "prod"
}   
}