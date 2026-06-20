variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex: dev)"
  type        = string
}

variable "location" {
  description = "Regiao da Azure"
  type        = string
}

variable "address_space" {
  description = "Espaços de enderecamento da rede"
  type        = list(string)
}

variable "vm_subnet_address_prefixes" {
  description = "Lista de prefixos de enderecamento para subnets de maquinas virtuais"
  type        = list(string)
}

variable "aks_subnet_address_prefixes" {
  description = "Lista de prefixos de enderecamento para subnets do AKS"
  type        = list(string)
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
}