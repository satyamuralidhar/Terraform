output "instance_ips" {
  value = aws_instance.myvms[*].private_ip
}