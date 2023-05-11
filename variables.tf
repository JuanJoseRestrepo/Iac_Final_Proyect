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

variable "aks_service_principal_app_id" {
  description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
}

variable "aks_service_principal_client_secret" {
  description = "Secret of the service principal. Used by AKS to manage Azure."
}

variable "aks_service_principal_object_id" {
  description = "Object ID of the service principal."
}