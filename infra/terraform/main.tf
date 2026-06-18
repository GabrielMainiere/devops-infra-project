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

module "compute" {
  source = "./modules/compute"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.network.resource_group_name
  subnet_id           = module.network.vm_subnet_id
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  tags                = local.common_tags
}

module "aks" {
  source = "./modules/aks"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.network.resource_group_name
  subnet_id           = module.network.aks_subnet_id
  node_count          = var.aks_node_count
  node_vm_size        = var.aks_node_vm_size
  tags                = local.common_tags
}