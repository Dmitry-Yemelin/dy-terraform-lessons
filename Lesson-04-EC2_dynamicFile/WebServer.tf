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


resource "aws_instance" "my_webserver" {
  ami                    = "ami-0be2609ba883822ec"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Dmitry",
    l_name = "Yemelin",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha", "Temp1ar"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Dmitry Yemelin"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
