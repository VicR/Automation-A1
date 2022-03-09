terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate01518013RG"
    storage_account_name = "tfstate01518013sa"
    container_name       = "tfstatefiles"
    key                  = "a1.terraform.tfstate"
  }
}
