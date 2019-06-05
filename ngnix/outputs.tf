output "publicip" {
  value = "${aws_instance.Appserver.public_ip}"
}
output "privateip" {
  value = "${aws_instance.Appserver.private_ip}"
}

