output "instance_ips" {
  value = aws_instance.myvms[*].public_ip
}
