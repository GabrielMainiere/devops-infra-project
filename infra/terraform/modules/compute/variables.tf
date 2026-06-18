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
  description = "ID da subnet"
  type        = string
}

variable "vm_size" {
  description = "Tamanho da VM"
  type        = string
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Caminho da chave publica SSH"
  type        = string
}

variable "tags" {
  description = "Tags dos recursos"
  type        = map(string)
}