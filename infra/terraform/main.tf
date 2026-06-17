locals {
  common_tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
  })
}

module "network" {
  source = "./modules/network"

  project_name                = var.project_name
  environment                 = var.environment
  location                    = var.location
  address_space               = var.address_space
  vm_subnet_address_prefixes  = var.vm_subnet_address_prefixes
  aks_subnet_address_prefixes = var.aks_subnet_address_prefixes
  tags                        = local.common_tags
}