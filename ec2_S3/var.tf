variable "secretkey" {
}
variable "accesskey" {
}
variable "ami" {
  default = "ami-0d7hjbjhbb2bb1c1"
}
variable "key_name" {
  default = "ansible"
}

variable "security_groups" {
  default = ["sec"]
}

