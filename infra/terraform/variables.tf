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