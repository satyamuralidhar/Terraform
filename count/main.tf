provider "aws" {
  region     = "${var.region}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}

terraform {
   backend "s3" {
    bucket_name = "tfstatefile"
    key = "terraform.tfstate"
    region = "${var.region}"
    dynamodb_table = "satya_db"
  }
}
resource "aws_instance" "murali" {
    count = "${var.count}"
    ami             = "${lookup(var.ami, var.region)}"
    instance_type   = "${var.type}"
    key_name        = "sample"
    security_groups = ["${aws_security_group.allow_all.id}"]

    #local execution inside the block
    # provisioner "local_exec" {
    #   command = "echo ${self.public_ip},${self.private_ip} >> public_private_ip.txt"
    # }
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

  connection {
    user = "satya"
    private_key = "${file(var.key_path)}"
  }
  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install apache2 -y"
    ]
  }


  #local exec out side lock 

  resource "null_resource" "file" {
    provisioner "local-exec" {
      command = " echo ${aws_instance.murali.private_ip},${aws.instance.murali.public_ip} >> private_public_ip.txt"
    }
  }

  
  tags = {
      name = "Satya-${count.index + 1}"
  }
  ##for list of tags
#   tags = {
#       name = "${element(var.assign_tags, count.index)}"
#   }


}

