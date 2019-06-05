provider "aws" {
  region     = "${var.location}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc}"

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
resource "aws_instance" "ram" {
    ami             = "${var.ami}"
    instance_type   = "t2.micro"
    key_name        = "ansible"
    security_groups = ["${var.firewall}"]
    
    tags {
      name = "ramana"
    }


   connection {
    user     = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }
  
   provisioner "remote-exec" {
       inline = [
           "sudo apt-get update",
           "sudo apt-get install default-jre -y",
           "sudo apt-get install default-jdk -y",
           "sudo add-apt-repository ppa:webupd8team/java",
           "sudo apt-get update",
           "sudo apt-get install oracle-java8-installer -y"
        ]

   }


}

