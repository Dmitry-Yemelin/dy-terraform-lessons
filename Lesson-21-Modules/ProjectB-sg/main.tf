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
  source          = "../modules/aws_security_group"
  env             = "prod"
  allow_port_list = ["80", "8080", "443"]
  vpc_id          = "vpc-0d9f29f37375ca201"
  ingress_cidr_blocks = ["10.0.0.0/16", "10.2.0.0/16"]
}
