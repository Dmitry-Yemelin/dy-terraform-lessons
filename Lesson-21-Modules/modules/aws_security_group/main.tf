#----------------------------------------------------------
# My Terraform
# Provision:
#  - SG
#  
# Made by Dmitry Yemelin.
#----------------------------------------------------------

#==============================================================

resource "aws_security_group" "my_SG" {
  name   = "Dynamic Security Group"
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.allow_port_list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      #cidr_blocks = ["0.0.0.0/0"]
      cidr_blocks = var.ingress_cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Dmitry Yemelin"
  }
}
