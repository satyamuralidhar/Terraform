provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.location}"
}

resource "aws_instance" "murali" {
    ami             = "${var.my_ami}"
    instance_type   = "${var.instance_type}"
    key_name        = "ansible"
    security_groups = ["${var.nsg}"]
}

output "instance" {
  value = "${aws_instance.murali.id}"
}


