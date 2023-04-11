
provider "azurerm" {
   features {}
}
module "APG" {
  source   = "./aishu/APG"
  apgname    = var.apgname
  rg_name   = var.rg_name
  location = var.location
  
}

