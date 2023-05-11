variable "resource_group_name" {
    type = string
}
variable "location" {
    type = string
}
variable "aks_name" {
    type = string
}
variable "aks_dns_prefix" {
    type = string
}
variable "subnet_id" {
    type = string
}
variable "app_gateway_id" {
    type = string
}
variable "user_assigned_identity_id" {
    type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "aks_service_principal_app_id" {
  description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
}

variable "aks_service_principal_client_secret" {
  description = "Secret of the service principal. Used by AKS to manage Azure."
}