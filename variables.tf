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
variable "apgname" {
  description = "Application Gateway"
  type        = string
}
variable "address_pre" {
  description = "address_pre"
  type        = string
}