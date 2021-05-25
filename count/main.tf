provider "aws" {
  region     = "${var.region}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
resource "aws_instance" "murali" {
    count = "${var.count}"
    ami             = "${lookup(var.ami, var.region)}"
    instance_type   = "${var.type}"
    key_name        = "murali"
    security_groups = ["nsg"]
}
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-064n9448"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
  tags = {
      name = "Satya-${count.index + 1}"
  }
  ##for list of tags
#   tags = {
#       name = "${element(var.assign_tags, count.index)}"
#   }


}

