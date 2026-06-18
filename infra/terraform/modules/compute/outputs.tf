output "vm_id" {
  description = "ID da VM"
  value       = azurerm_linux_virtual_machine.api_gateway.id
}

output "vm_name" {
  description = "Nome da VM"
  value       = azurerm_linux_virtual_machine.api_gateway.name
}

output "public_ip_address" {
  description = "IP publico da VM"
  value       = azurerm_public_ip.api_gateway.ip_address
}

output "private_ip_address" {
  description = "IP privado da VM"
  value       = azurerm_network_interface.api_gateway.private_ip_address
}

output "admin_username" {
  description = "Usuario administrador"
  value       = var.admin_username
}