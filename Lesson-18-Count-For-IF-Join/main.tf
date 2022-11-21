#----------------------------------------------------------
# My Terraform
#
# Terraform Loops: Count and For if
#
# Made by Dmitry Yemelin
#----------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}


resource "aws_iam_user" "user1" {
  name = "pushkin"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

#----------------------------------------------------------------

resource "aws_instance" "servers" {
  count         = 2
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t3.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}
