resource "azurerm_log_analytics_workspace" "a1_law" {
  name                = var.law_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.law_sku
  retention_in_days   = var.ret_days
  tags                = var.tags
  depends_on          = [var.resource_group]
}

resource "azurerm_recovery_services_vault" "a1_rsv" {
  name                = var.rsv_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.rsv_sku
  tags                = var.tags
  depends_on          = [var.resource_group]
}

resource "azurerm_storage_account" "a1_sa" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.sa_tier
  account_replication_type = var.sa_type
  tags                     = var.tags
  depends_on               = [var.resource_group]
}
