output "cluster_id" {
  description = "ID do AKS"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  description = "Nome do AKS"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  description = "Resource Group onde o AKS foi criado"
  value       = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "web_app_routing_identity_object_id" {
  description = "Object ID da identidade gerenciada do Web App Routing"
  value       = azurerm_kubernetes_cluster.aks.web_app_routing[0].web_app_routing_identity[0].object_id
}

output "web_app_routing_identity_client_id" {
  description = "Client ID da identidade gerenciada do Web App Routing"
  value       = azurerm_kubernetes_cluster.aks.web_app_routing[0].web_app_routing_identity[0].client_id
}