provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.region}"
}
resource "aws_s3_bucket" "satya" {
 
  acl    = "private"
  tags {
    Name        = "murali"
    Environment = "Dev"
  }
}