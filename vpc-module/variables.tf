variable "mycidr" {
  type = string
}

variable "project_tag" {
  type = map(string)
}

variable "environment" {
  type = string
}
variable "igw" {
  type = string
}

variable "publicsubnet" {
  type = list(string)
}

variable "privatesubnet" {
  type = list(string)
}

variable "privatedatabasesubnet" {
  type = list(string)
}

variable "publicrt" {
  type = list(string)
}

variable "privatert" {
  type = list(string)
}

variable "privatedatabasert" {
  type = list(string)
}

variable "route" {
  default = ""
}
variable "peering_is_required" {
  type    = bool
  default = true
}