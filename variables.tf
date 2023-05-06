variable "client_id" {
  description = "Client ID for the service principal"
}

variable "client_secret" {
  description = "Client secret for the service principal"
}

variable user {
  type = string
  description = "Usuario de conexión a la maquina virtual"
}

variable password {
  type = string
  description = "Password de conexión a la maquina virtual"
}