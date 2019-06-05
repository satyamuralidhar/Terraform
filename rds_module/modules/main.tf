provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.location}"
}

module "securitygroup" {
  source = ".//modules"
  
}

resource "aws_db_subnet_group" "murali" {
  name       = "murali"
  subnet_ids = ["${var.subnets}"]

  tags {
    Name = "My DB subnet group"
  }
}