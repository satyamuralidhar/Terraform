resource "null_resource" "echo" {
}
resource "null_resource" "timestamp" {
    depends_on = [null_resource.echo]

provisioner "local-exec" {
      command=formatdate("YYYY-MM-DD-hh:mm:ss",timestamp())
      on_failure = continue
}
}
output "time" {
  value = null_resource.timestamp.triggers
}
output "id" {
    value = null_resource.timestamp.id
} 
