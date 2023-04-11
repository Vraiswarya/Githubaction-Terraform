
provider "azurerm" {
   features {}
}
module "APG" {
  source   = "./aishu/APG"
  apgname    = var.apgname
  rg_name   = var.rg_name
  location = var.location
  
}
module "RG" {
    source   = "./aishu/RG" #A 
    rg_name   = var.rg_name     #B 
    location = var.location
}
module "ACR" {
    source   = "./aishu/ACR" #A 
    rg_name  = var.rg_name     #B 
    acr_name = var.acr_name  
    location = var.location
}
