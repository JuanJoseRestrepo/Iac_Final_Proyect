resource "azurerm_resource_group" "resources_az" {
  name     = "resources"
  location = "East US"
}

resource "azurerm_virtual_network" "vn_azure" {
  name                = "azure_virtual_network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resources_az.location
  resource_group_name = azurerm_resource_group.resources_az.name
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "subnet_azure"
  resource_group_name  = azurerm_resource_group.resources_az.name
  virtual_network_name = azurerm_virtual_network.vn_azure.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "appgw_subnet"
  resource_group_name  = azurerm_resource_group.resources_az.name
  virtual_network_name = azurerm_virtual_network.vn_azure.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "public_ip_azure"
  location            = azurerm_resource_group.resources_az.location
  resource_group_name = azurerm_resource_group.resources_az.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_user_assigned_identity" "user" {
name = "user"
location = azurerm_resource_group.resources_az.location
resource_group_name = azurerm_resource_group.resources_az.name
}

resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-azure"
  location            = azurerm_resource_group.resources_az.location
  resource_group_name = azurerm_resource_group.resources_az.name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "example-gateway-ip"
    subnet_id = azurerm_subnet.app_gateway_subnet.id
  }

  frontend_ip_configuration {
    name                 = "example-frontend-ip"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  frontend_port {
    name = "example-frontend-port"
    port = 80
  }

  backend_address_pool {
    name = "backend-address-pool"
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

 http_listener {
   name                           = "http-listener"
   frontend_ip_configuration_name = "example-frontend-ip"
   frontend_port_name             = "example-frontend-port"
   protocol                       = "Http"
  }

request_routing_rule {
  name                       = "routing-rule"
  rule_type                  = "Basic"
  http_listener_name         = "http-listener"
  backend_address_pool_name  = "backend-address-pool"
  backend_http_settings_name = "backend-http-settings"
  priority                   = 1 # Add this line to define the priority
}


  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.user.id
    ]
  }

}

resource "azurerm_container_registry" "az_cr" {
  name                = "cr15282813281328132813281328132813"
  resource_group_name = azurerm_resource_group.resources_az.name
  location            = azurerm_resource_group.resources_az.location
  sku                 = "Basic"
  admin_enabled       = true
}

module "cluster" {
  source = "./modules/cluster"
  resource_group_name       = azurerm_resource_group.resources_az.name
  location                  = azurerm_resource_group.resources_az.location
  aks_name                  = "azure-aks"
  aks_dns_prefix            = "azure-aks"
  subnet_id                 = azurerm_subnet.app_gateway_subnet.id
  app_gateway_id            = azurerm_application_gateway.appgw.id
  user_assigned_identity_id = azurerm_user_assigned_identity.user.id
  client_id     = var.client_id
  client_secret = var.client_secret
}

module "vm" {
  source = "./modules/vm"
  resource_group_name       = azurerm_resource_group.resources_az.name
  location                  = azurerm_resource_group.resources_az.location
  subnet_id = azurerm_subnet.vm_subnet.id
  user =  var.user
  password = var.password
}