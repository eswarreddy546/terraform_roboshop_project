variable "ami" {
    type = string
}
variable "type" {
  type        = string
  description = "The type of EC2 instance to provision."

  validation {
    condition     = contains(["t3.micro", "t3.small", "t2.small"], var.type)
    error_message = "The instance_type must be one of: t3.micro, t3.small, or t2.micro."
  }
}

variable "group" {
    type = list(string)
}
variable "tags" {
    type = map(string)

}
