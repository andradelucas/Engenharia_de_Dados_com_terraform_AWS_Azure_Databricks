resource "aws_security_group" "permite_ssh_2" {
  
  name = "permite_ssh_2"
  
  description = "Security Group EC2 Instance"

  ingress {

    description = "Inbound Rule"
    from_port = 22
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    description = "Outbound Rule"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

}

resource "aws_instance" "Web_server" {
  
  ami = "ami-0a0d9cf81c479446a"  
  
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.permite_ssh_2.id]
  
  key_name = "EC2_conect"

  tags = {
    Name = "lab3-t4-terraform"
  }

  provisioner "file" {
    source      = "script_config.sh"
    destination = "/tmp/script_config.sh"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("EC2_conect.pem")
      host     = self.public_ip
    }
  }

  provisioner "remote-exec" {
    
    inline = ["chmod +x /tmp/script_config.sh", "/tmp/script_config.sh"]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("EC2_conect.pem")
      host     = self.public_ip
    }
  }
}
