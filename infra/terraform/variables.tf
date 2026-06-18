variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "weather-devops"
}

variable "environment" {
  description = "Ambiente (ex: dev)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Regiao da Azure"
  type        = string
  default     = "northcentralus"
}

variable "address_space" {
  description = "Espaços de enderecamento da rede"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "vm_subnet_address_prefixes" {
  description = "Lista de prefixos de enderecamento para subnets de maquinas virtuais"
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "aks_subnet_address_prefixes" {
  description = "Lista de prefixos de enderecamento para a subnet do AKS"
  type        = list(string)
  default     = ["10.20.2.0/23"]
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)

  default = {
    project = "weather-devops"
    owner   = "student"
  }
}

variable "vm_size" {
  description = "Tamanho da VM da API e Gateway"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Usuario administrador da VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Caminho da chave publica SSH usada para acessar a VM"
  type        = string
  default     = "C:/Users/gsmai/.ssh/id_azure_terraform.pub"
}

variable "aks_node_count" {
  description = "Quantidade de worker nodes"
  type        = number
  default     = 2
}

variable "aks_node_vm_size" {
  description = "Tamanho das VMs do AKS"
  type        = string
  default     = "Standard_D2s_v3"
}