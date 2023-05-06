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

variable "public_ssh_key_path" {
  description = "Public key path for SSH."
  default     = "~/.ssh/id_rsa.pub"
}