resource "azurerm_postgresql_server" "a1_postgres_server" {
  name                         = var.server_name
  location                     = var.location
  resource_group_name          = var.rg_name
  sku_name                     = var.server_sku
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true
  administrator_login          = var.db_username
  administrator_login_password = var.db_password
  version                      = var.db_version
  ssl_enforcement_enabled      = true
  tags                         = var.tags
}

resource "azurerm_postgresql_database" "a1_postgres_db" {
  name                = var.db_name
  resource_group_name = var.rg_name
  server_name         = var.server_name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on          = [azurerm_postgresql_server.a1_postgres_server]
}
