provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.93.0"
    }
  }
  required_version = "~> 1.1.2"
}

locals {
  common_tags = {
    Project         = "Automation Project - Assignment 1"
    Name            = "Victor.Rendon"
    ExpirationDate  = "2022-03-08"
    Environment     = "Lab"
  }
}