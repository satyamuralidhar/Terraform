provider "aws" {
  region     = "us-west-2"
  access_key = "AuonS49ujer8wefi2f4"
  secret_key = "NHFIF3CKe3kfm334d/ehfmo"
}
resource "aws_instance" "murali" {
    ami             = "ami-0m6cb03f730"
    instance_type   = "t2.micro"
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
}

