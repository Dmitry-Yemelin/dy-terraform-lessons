provider "aws" {
  #region = "us-east-1"
}


data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}
data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "NOVA_VPC"
  }
}

output "NOVA_VPC_id" {
  value = data.aws_vpc.prod_vpc.id
}
output "NOVA_VPC_cidr" {
  value = data.aws_vpc.prod_vpc.cidr_block
}

resource "aws_subnet" "NOVA_VPC_prod_subnet_1" {
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "172.32.1.0/24"
  tags = {
    Name    = "Subnet-1 ${data.aws_availability_zones.working.names[0]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

resource "aws_subnet" "NOVA_VPC_prod_subnet_2" {
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block        = "172.32.2.0/24"
  tags = {
    Name    = "Subnet-2 ${data.aws_availability_zones.working.names[1]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}
output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}
output "data_aws_region_name" {
  value = data.aws_region.current.name
}
output "data_aws_region_description" {
  value = data.aws_region.current.description
}
output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}
