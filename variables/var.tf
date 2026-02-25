variable "ami" {
  default = "ami-0220d79f3f480ecf5"
}

variable "instance_type" {
  type = string
}

variable "cidr" {
  default = ["0.0.0.0/0"]
  
}
variable "to_port" {
  default = 0
}

variable "from_port" {
  default = 0
}

variable "protocol" {
  default = "-1"
  
}

variable "tags" {
  default = {
    name = "eswar"
    project = "dev"
  }
  
}