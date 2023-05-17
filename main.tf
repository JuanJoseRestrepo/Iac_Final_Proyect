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

resource "azurerm_user_assigned_identity" "user" {
name = "user"
location = azurerm_resource_group.resources_az.location
resource_group_name = azurerm_resource_group.resources_az.name
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
  user_assigned_identity_id = azurerm_user_assigned_identity.user.id
  client_id     = var.client_id
  client_secret = var.client_secret
  aks_service_principal_app_id = var.aks_service_principal_app_id
  aks_service_principal_client_secret = var.aks_service_principal_client_secret
}

module "vm" {
  source = "./modules/vm"
  resource_group_name       = azurerm_resource_group.resources_az.name
  location                  = azurerm_resource_group.resources_az.location
  subnet_id = azurerm_subnet.vm_subnet.id
  user =  var.user
  password = var.password
}