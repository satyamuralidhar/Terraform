resource "aws_vpc" "myvpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Name" = format("%s-%s", terraform.workspace, "network")
  }
}

resource "aws_subnet" "mysubnet" {
  count             = length(var.cidr)
  cidr_block        = element(var.cidr, count.index)
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = element(var.availbility_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = format("%s-%s-%s", terraform.workspace, "subnet", count.index + 1)
  }
}
resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = format("%s-%s", terraform.workspace, "gateway")
  }
}

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
  dynamic "egress" {
    for_each = var.egress_rules
    iterator = egress_port
    content {
      from_port       = egress_port.value
      to_port         = egress_port.value
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = format("%s-%s", terraform.workspace, "ingress-rules")
  }
}

# resource "aws_egress_only_internet_gateway" "egw" {
#   vpc_id = aws_vpc.myvpc.id
# }

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygateway.id
  }
  #   route {
  #   ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = aws_egress_only_internet_gateway.egw.id
  # }
  tags = {
    "Name" = format("%s-%s", terraform.workspace, "routetable")
  }
}

resource "aws_route_table_association" "rtallocation" {
  count = length(var.cidr)
  subnet_id = element(aws_subnet.mysubnet.*.id,count.index)
  //gateway_id     = aws_internet_gateway.mygateway.id
  route_table_id = aws_route_table.myroute.id
}
data "aws_key_pair" "key" {}

resource "aws_instance" "myvms" {
  count = (terraform.workspace == "dev" ? 1 : 3)
  instance_type = var.instance_type
  ami = var.ami_id
  //security_groups = [data.aws_security_group.dsg.id]
  security_groups = [aws_security_group.mynsg.id]
  key_name = data.aws_key_pair.key.key_name
  subnet_id = aws_subnet.mysubnet[0].id

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(var.path)}"
    host = "${element(self.*.public_ip,count.index)}"
    //host = "${element(aws_instance.myvms.*.public_ip,count.index)}"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo service nginx restart"
    ]
  }

  depends_on = [
    aws_vpc.myvpc
  ]
  tags = {
    "Name" = format("%s-%s-%s",terraform.workspace,"server",count.index+1)
  }
}

# variable "instances" {
#   type = map(object({
#     instance_type = map(string)
#     //ami = string
#   }))
#   default     = {}
# }
# locals {
#   instance = flatten([
#     for k,v  in var.instances : [
#       for amis in v.instance_type : { 
#         instance_type = v.instance_type
#         //ami = v.ami
#       }
#     ]
#   ])
# }

# resource "aws_instance" "myinstance" {
#   for_each = {for ami_id , name in local.instance : name.ami => name }
#   instance_type = each.value.instance_type
#   ami = ""
#   security_groups = [ aws_security_group.mynsg.id ]
#   subnet_id = aws_subnet.mysubnet[0].id
#   depends_on = [
#     aws_vpc.myvpc,
#     aws_subnet.mysubnet[0]
#   ]
#   tags = {
#     "Name" = each.key
#     //"Name" = format("%s-%s",var.instances)
#   }
#}
