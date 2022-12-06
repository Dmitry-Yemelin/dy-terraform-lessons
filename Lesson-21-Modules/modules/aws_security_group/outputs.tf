
output "securityGroup_full" {
  value = aws_security_group.my_SG
}


output "securityGroup" {
  value = aws_security_group.my_SG.id
}

output "SG_ports_IN" {
  value = aws_security_group.my_SG.ingress.*.from_port
}

