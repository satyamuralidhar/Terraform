provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Create a web server
resource "aws_instance" "Appserver" {
  # ...

  ami             = "${var.ami}"
  security_groups = ["${aws_security_group.allow_all.name}"]
  key_name        = "${var.key_name}"
  instance_type   = "${var.instance_type}"

  connection {
    user        = "ubuntu"
    private_key = "${file(var.privatekeypath)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install tomcat7 -y",
      "sudo service tomcat7 start",
    ]
  }
}

resource "aws_instance" "Appserver-2" {
  # ...

  ami             = "${var.ami}"
  security_groups = ["${aws_security_group.allow_all.name}"]
  key_name        = "${var.key_name}"
  instance_type   = "${var.instance_type}"

  connection {
    user        = "ubuntu"
    private_key = "${file(var.privatekeypath)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo service nginx start",
    ]
  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
