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

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet do AKS"
  type        = string
}

variable "node_count" {
  description = "Quantidade de worker nodes"
  type        = number
}

variable "node_vm_size" {
  description = "Tamanho das VMs dos worker nodes"
  type        = string
}

variable "tags" {
  description = "Tags dos recursos"
  type        = map(string)
}