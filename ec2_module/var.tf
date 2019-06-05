variable "accesskey" {
  
}
variable "secretkey" {
  
}
variable "location" {
  default = "ap-south-1"
}
variable "subnet" {
  default = "subnet-s752436"
}
variable "pem" {
  default = "ansible"
}

variable "sg" {
  default = ["sg-09hghjb5ji8a12"]
}



variable "ami_id" {
  default = "ami-04ea9986v659d6b"
}
