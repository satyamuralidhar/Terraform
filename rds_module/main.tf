provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.location}"
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.22.0"

 
  # insert the 10 required variables here
  identifier = "RDS_db"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  name     = "RDS_db"
  username = "murali"
  password = "@satya999"
  port     = "3306"

  iam_database_authentication_enabled = true
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  vpc_security_group_ids = ["${var.sg}"]
  subnet_ids= ["${var.subnet}"]
}



  