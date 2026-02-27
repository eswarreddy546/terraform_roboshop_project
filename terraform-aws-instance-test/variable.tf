variable "ami_type" {
    type = string
    default = "ami-0220d79f3f480ecf5"
}
variable "type" {
    type = string
    default = "t2.small"

}

variable "group" {

    type = list(string)
    default = [ "sg-0592ca6af1fb87f46" ]
}
variable "tags" {
    type = map(string)
    default = {
      "project" = "roboshop-module"
    }

}
