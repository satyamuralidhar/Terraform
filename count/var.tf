
variable "accesskey" {}
variable "secretkey" {}

variable "region" {
  default = "us-west-2"
}

variable "type" {
  default = "t2.micro"
}

variable "count" {
  default = "3"
}


variable "ami" {
    type = "map"
    default = {
        us-west-1 = "ami-0m6cb023450"
        us-west-2 = "ami-0m6cb03f530"
    }
}

# variable "assign_tags" {
#     type = "list"
#     default = ["Satya-1","Satya-2","Satya-3"]
# }

