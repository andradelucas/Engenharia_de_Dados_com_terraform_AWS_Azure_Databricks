resource "aws_security_group" "permite_ssh" {
  
  name = "permite_ssh"
  
  description = "Security Group EC2 Instance"

  ingress {

    description = "Inbound Rule"
    from_port = 22
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["104.28.243.220/32"]

  }

  egress {

    description = "Outbound Rule"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["104.28.243.220/32"]

    }

}

resource "aws_instance" "Web_server" {
  
  ami = "ami-0a0d9cf81c479446a"  
  
  instance_type = var.instance_type
  
  key_name = "EC2_conect"

  tags = {
    Name = "lab3-t3-terraform"
  }

  provisioner "remote-exec" {
    
    inline = ["sudo yum update -y", 
              "sudo yum install httpd -y", 
              "sudo systemctl start httpd", 
              "sudo bash -c 'echo Criando segundo server com terraform :)   > /var/www/html/index.html'"]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("EC2_conect.pem")
      host     = self.public_ip
    }
  }
}
