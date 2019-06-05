
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}
resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = 8
  type              = "gp2"
   tags = {
    Name = "Satya"
  }

  
}