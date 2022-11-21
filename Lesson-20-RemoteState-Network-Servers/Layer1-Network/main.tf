#----------------------------------------------------------
# My Terraform
#
# Remote State on S3
#
# Made by Dmitry Yemelin
#----------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "dmitry-yemelin-project-terraform-state" // Bucket where to SAVE Terraform State
    key    = "dev/network/terraform.tfstate"          // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                              // Region where bycket created
  }
}

#==============================================================

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}
output "aws_subnet_public_subnets" {
  value = aws_subnet.public_subnets
}


resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}-route-public-table"
  }
}

output "aws_route_table-public_subnets" {
  value = aws_route_table.public_subnets
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}
output "aws_route_table_association_public_routes" {
  value = aws_route_table_association.public_routes[*].id
}


#==============================================================
