provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "ap-south-1"
}
resource "aws_instance" "murali" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    monitoring = "false"
    security_groups = ["${var.security_groups}"]
    
     tags {
    Name = "satya"
     }
}     
