provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

resource "aws_instance" "my_amazon_linux" {
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t3.nano"

  tags = {
    Name    = "My amazon server"
    Owner   = "Dmitry Yemelin"
    Project = "Terraform lessons"
  }
}
