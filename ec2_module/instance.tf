provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.location}"
}
module "ec2-instance" {
  source                  = "terraform-aws-modules/ec2-instance/aws"
  version                 = "1.12.0"
  name                    = "satya"
  ami                     = "${var.ami_id}"
  instance_type           = "t2.micro"
  key_name                = "${var.pem}"
  monitoring              = false
  vpc_security_group_ids  = ["${var.sg}"] 
  subnet_id               = "${var.subnet}"
  tags = {
    Terraform     = "true"
    Environment   = "dev"
  }
}