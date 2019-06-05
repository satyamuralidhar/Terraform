provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.location}"
}
module "mysg" {
  source = ".//modules//sg"
  
}


output "security" {
  value = "${module.mysg.securitygroupid}"
}

