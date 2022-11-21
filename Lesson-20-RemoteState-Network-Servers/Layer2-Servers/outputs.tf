
output "webserver_sg_id" {
  value = aws_security_group.webserver.id
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "web_server_instance_type" {
  value = aws_instance.web_server.instance_type
}
