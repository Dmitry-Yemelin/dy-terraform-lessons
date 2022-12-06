variable "env" {
  default = "dev"
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
  #default = "vpc-0d9f29f37375ca201"
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "allow_port_list" {
  description = "List of Ports to open for server"
  default     = ["80", "443"]
}
