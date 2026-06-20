resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.project_name}-${var.environment}"

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = var.node_vm_size
    vnet_subnet_id = var.subnet_id

    type = "VirtualMachineScaleSets"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.cluster_identity_id]
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  web_app_routing {
    dns_zone_ids             = []
    default_nginx_controller = "Internal"
  }

  tags = var.tags
}