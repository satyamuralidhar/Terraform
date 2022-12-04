
variable "env" {
  default = "dev"
}
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
  default = ["8080", "80", "22"]
}
# variable "subnets" {
#   type = object({
#     cidr_block = string
#     vpc_id = string
#     availbility_zone = string

#   })
# }