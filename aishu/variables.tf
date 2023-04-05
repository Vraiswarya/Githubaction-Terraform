variable "rg_name" {
  type  = string
  description = "resource group name."
}
variable "location" {
  type  = string
  default = "westeurope"
}
variable "acr_name" {
  type  = string
  default = "ACR name"
}
