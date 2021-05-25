resource "null_resource" "copying" {
    connection {
        user = "satya"
        type = "ssh"
        host = "${aws_instance.murali.public_ip}"
        key_name = "${file(var.key_path)}"
    }
    provisioner "file" {
        source = "git.yaml"
        destination = "/home/ansible/scripts/git.yaml"
    }
    provisioner "remote-exec" {
        inline = [
            "hostname -i >> sample.txt"
        ]
    }

    depends_on = [
        "${aws_instance.murali}"
    ]


    
}