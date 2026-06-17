output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = module.network.resource_group_name
}

output "resource_group_location" {
  description = "Regiao do Resource Group"
  value       = module.network.resource_group_location
}

output "vnet_id" {
  description = "ID da VNet"
  value       = module.network.vnet_id
}

output "vm_subnet_id" {
  description = "ID da subnet da VM"
  value       = module.network.vm_subnet_id
}

output "aks_subnet_id" {
  description = "ID da subnet do AKS"
  value       = module.network.aks_subnet_id
}