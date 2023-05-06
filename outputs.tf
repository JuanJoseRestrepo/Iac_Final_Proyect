output "kube_config" {
  value = module.cluster.kube_config
  sensitive = true
}

output "client_certificate" {
  value = module.cluster.client_certificate
  sensitive = true
}

output ip_nic_vm {
    value = module.vm.ip_nic_vm
}

output ip_nic_vm2 {
    value = module.vm2.ip_nic_vm2
}