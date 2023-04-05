
provider "azurerm" {
   features {}
}
resource "azurerm_resource_group" "resourcegrp" {
    name= var.rg_name
    location= var.location
}
#acr
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.resourcegrp.name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
 
}
