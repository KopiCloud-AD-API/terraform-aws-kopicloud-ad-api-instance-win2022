#####################################
## Virtual Machine Module - Output ##
#####################################

output "vm_api_server_instance_name" {
  value = var.api_instance_name
}

output "vm_api_server_instance_id" {
  value = aws_instance.api-server.id
}

output "vm_api_server_instance_public_dns" {
  value = aws_instance.api-server.public_dns
}

output "vm_api_server_instance_public_ip" {
  value = aws_eip.api-eip.public_ip
}

output "vm_api_server_instance_private_ip" {
  value = aws_instance.api-server.private_ip
}
