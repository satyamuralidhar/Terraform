#     subnets = {
#         subnet1 = {
#             cidr_block = "10.0.1.0/24"
#             vpc_id = aws_vpc.myvpc.id
#             availbility_zone = var.availbility_zones[0]
#         },
#         subnet2 = {
#             cidr_block = "10.0.2.0/24"
#             vpc_id = aws_vpc.myvpc.id
#             availbility_zone = var.availbility_zones[1]
#         }
# }
# instances = {
#   instance1 = {

#     instance_type = "t2.micro"
  //}
  # instance2 = {
 
  #   instance_type = "t2.micro"
  # }
  # instance3 = {
  #   instance_type = "t2.micro"
  # }
#}

ami_id = ""
instance_type = "t2.micro"