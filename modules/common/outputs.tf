output "law_name" {
  value = azurerm_log_analytics_workspace.a1_law.name
}

output "rsv_name" {
  value = azurerm_recovery_services_vault.a1_rsv.name
}

output "sa_name" {
  value = azurerm_storage_account.a1_sa.name
}

output "sa_uri" {
  value = azurerm_storage_account.a1_sa.primary_blob_endpoint
}
