variable "availbility_zones" {
  type    = list(any)
  default = ["ap-south-1a", "ap-south-1b"]
}
variable "cidr" {
  type    = list(any)
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "ingress_rules" {
  type    = list(any)
  default = ["22","80","443","8080"]
}
variable "egress_rules" {
  type    = list(any)
  default = ["0"]
}
# variable "subnets" {
#   type = object({
#     cidr_block = string
#     vpc_id = string
#     availbility_zone = string

#   })
# }
variable "ami_id" {}
variable "instance_type" {}
variable "path" {
  default = "key/k8s.pem"
}
