variable "law_name" {}
variable "rsv_name" {}
variable "sa_name" {}
variable "resource_group" {}
variable "rg_name" {}
variable "location" {}
variable "tags" {}

variable "law_sku" {
  default = "PerGB2018"
}

variable "ret_days" {
  default = "30"
}

variable "rsv_sku" {
  default = "Standard"
}

variable "sa_tier" {
  default = "Standard"
}

variable "sa_type" {
  default = "LRS"
}
