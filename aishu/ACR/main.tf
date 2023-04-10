resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rgname
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
 
}