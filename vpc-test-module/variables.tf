variable "cidr_blocks" {
  default = "10.0.0.0/16"
}

variable "project_tags" {
  default = {
    name    = "roboshop"
    project = "dev"
  }
}

variable "environment" {
  default = "vpc-dev"
}

variable "igw" {
  type = string
default = ""
}

variable "publicsubnet" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "privatesubnet" {
  default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "privatedatabasesubnet" {
  default = ["10.0.5.0/24","10.0.6.0/24"]
}



variable "publicrt" {
  default = [""]
  
}
variable "privatert" {
  default = [""]
  
}

variable "privatedatabasert" {
  default = [""]
  
}

variable "route" {
  default = "0.0.0.0/0"
  
}