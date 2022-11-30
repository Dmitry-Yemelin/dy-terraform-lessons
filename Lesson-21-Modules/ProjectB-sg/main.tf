#----------------------------------------------------------
# My Terraform
#
# Use Our Terraform Module to create AWS SG
#
# Made by Dmitry Yemelin.
#----------------------------------------------------------
provider "aws" {
  region = var.region
}


module "dynamicSG" {
  source = "../modules/aws_security_group"
  env    = "prod"
  allow_port_list = {
    "prod" = ["80", "8080", "443"]
  }
}
