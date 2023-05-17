output "kube_config" {
  value = module.cluster.kube_config
  sensitive = true
}

output "client_certificate" {
  value = module.cluster.client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value = module.cluster.cluster_ca_certificate
  sensitive = true
}

output "cluster_username" {
  value = module.cluster.cluster_username
  sensitive = true
}

output "cluster_password" {
  value = module.cluster.cluster_password
  sensitive = true
}

output ip_nic_vm {
    value = module.vm.ip_nic_vm
}

output "identity_resource_id" {
  value = azurerm_user_assigned_identity.user.id
}

output "identity_client_id" {
  value = azurerm_user_assigned_identity.user.client_id
}
