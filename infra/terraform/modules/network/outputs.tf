output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "Localização do Resource Group"
  value       = azurerm_resource_group.rg.location
}

output "vnet_id" {
  description = "ID da VNet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Nome da VNet"
  value       = azurerm_virtual_network.vnet.name
}

output "vm_subnet_id" {
  description = "ID da subnet da VM"
  value       = azurerm_subnet.vm_subnet.id
}

output "aks_subnet_id" {
  description = "ID da subnet do AKS"
  value       = azurerm_subnet.aks_subnet.id
}

output "vm_nsg_id" {
  description = "ID do NSG da VM"
  value       = azurerm_network_security_group.nsg.id
}