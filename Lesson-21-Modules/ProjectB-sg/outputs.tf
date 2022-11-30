
output "securityGroup_full" {
  value = module.dynamicSG.securityGroup_full
}


output "securityGroup" {
  value = module.dynamicSG.securityGroup
}


output "SG_ports_IN" {
  value = module.dynamicSG.SG_ports_IN
}
