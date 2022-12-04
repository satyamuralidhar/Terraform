resource "aws_vpc" "myvpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Name" = format("%s-%s", var.env, "network")
  }
}
# locals {
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
#     resource_subnet = flatten([
#         for k,v in subnets : [
#             for subnet in resource_subnet : {
#                 cidr_block = v.cidr_block
#                 vpc_id = v.vpc
#                 availbility_zone = v.availbility_zone
#             }
#         ]
#     ])
# }
resource "aws_subnet" "mysubnet" {
  count             = length(var.cidr)
  cidr_block        = element(var.cidr, count.index)
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = element(var.availbility_zones, count.index)
  tags = {
    "Name" = format("%s-%s-%s", var.env, "subnet", count.index + 1)
  }
}
resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = format("%s-%s", var.env, "gateway")
  }
}

# resource "aws_internet_gateway_attachment" "mygatewayattchment" {
#   internet_gateway_id = aws_internet_gateway.mygateway.id
#   vpc_id = aws_vpc.myvpc.id
# }

resource "aws_security_group" "mynsg" {
  name   = "ssh-http-jenkins"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    iterator = ingress_port
    content {
      from_port   = ingress_port.value
      to_port     = ingress_port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = format("%s-%s", var.env, "ingress-rules")
  }
}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygateway.id
  }
  tags = {
    "Name" = format("%s-%s", var.env, "routetable")
  }
}

resource "aws_route_table_association" "rtallocation" {
  subnet_id      = aws_subnet.mysubnet[0].id
  route_table_id = aws_route_table.myroute.id
}
