resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "agic-aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "agic-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

    service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.1.0.0/16"
    dns_service_ip = "10.1.0.10"
  }
}

resource "local_file" "foo" {
  content  = azurerm_kubernetes_cluster.k8s.kube_config_raw
  filename = "azurek8s"
}
