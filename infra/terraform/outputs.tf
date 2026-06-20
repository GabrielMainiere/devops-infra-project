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

output "api_gateway_vm_name" {
  description = "Nome da VM da API e Gateway"
  value       = module.compute.vm_name
}

output "api_gateway_public_ip" {
  description = "IP publico da VM da API e Gateway"
  value       = module.compute.public_ip_address
}

output "api_gateway_private_ip" {
  description = "IP privado da VM da API e Gateway"
  value       = module.compute.private_ip_address
}

output "api_gateway_admin_username" {
  description = "Usuario administrador da VM"
  value       = module.compute.admin_username
}

output "aks_cluster_name" {
  description = "Nome do cluster AKS"
  value       = module.aks.cluster_name
}

output "aks_resource_group_name" {
  description = "Resource Group do AKS"
  value       = module.aks.resource_group_name
}

output "web_app_routing_identity_object_id" {
  description = "Object ID da identidade do Web App Routing"
  value       = module.aks.web_app_routing_identity_object_id
}

output "web_app_routing_identity_client_id" {
  description = "Client ID da identidade do Web App Routing"
  value       = module.aks.web_app_routing_identity_client_id
}