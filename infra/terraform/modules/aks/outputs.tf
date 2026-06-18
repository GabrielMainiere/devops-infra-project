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

output "kube_config" {
  description = "Kubeconfig do AKS"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}