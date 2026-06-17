resource "azurerm_resource_group" "rg" {
    name     = "${var.project_name}-${var.environment}-rg"
    location = var.location
    tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-${var.project_name}-${var.environment}"
    address_space       = var.address_space
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = var.tags
}

resource "azurerm_subnet" "vm_subnet" {
    name                 = "subnet-vm-${var.project_name}-${var.environment}"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = var.vm_subnet_address_prefixes
}

resource "azurerm_subnet" "aks_subnet" {
    name                 = "subnet-aks-${var.project_name}-${var.environment}"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = var.aks_subnet_address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
    name                = "nsg-vm-${var.project_name}-${var.environment}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = var.tags

    security_rule {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowHTTPGateway"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "vm" {
    subnet_id                 = azurerm_subnet.vm_subnet.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}