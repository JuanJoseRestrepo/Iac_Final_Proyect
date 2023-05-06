variable "location" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable user {
  type = string
  description = "Usuario de conexión a la maquina virtual"
}

variable password {
  type = string
  description = "Password de conexión a la maquina virtual"
}