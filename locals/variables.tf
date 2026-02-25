variable "project" {
    default = "roboshop"
  
}
variable "pro" {
    default = "roboshop_dev"
  
}

variable "common_tags" {
    type = map
    default = {
        Terraform = "true"
        Project = "roboshop"
        Environment = "dev"
    }

}