#----------------------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Dmitry Yemelin
#----------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}


resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  tags = {
    Name  = "Web Server IP"
    Owner = "Dmitry Yemelin"
  }
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-0be2609ba883822ec"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Denis",
    l_name = "Astahov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha", "Lena", "Katya"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Dmitry Yemelin"
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    #ignore_changes = ["ami", "user_data"]
  }

}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Dmitry Yemelin"
  }
}
