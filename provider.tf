terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54.0" # You can use a different version if necessary
    }
  }
}

provider "azurerm" {
  features {}
}