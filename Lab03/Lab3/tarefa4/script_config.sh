#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo mkdir -p /var/www/html
echo 'Criando a terceira pagina web com terraform' | sudo tee /var/www/html/index.html
