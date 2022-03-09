resource "azurerm_managed_disk" "data_disk_linux" {
  count                = var.nb_count
  name                 = "${element(var.linux_names[*], count.index + 1)}-data-disk"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = var.sa_type
  create_option        = var.option
  disk_size_gb         = var.disk_size
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "assignment1-attach-linux" {
  count              = var.nb_count
  virtual_machine_id = element(var.linux_ids[*], count.index)
  managed_disk_id    = element(azurerm_managed_disk.data_disk_linux[*].id, count.index + 1)
  lun                = "10"
  caching            = var.caching_type
  depends_on         = [azurerm_managed_disk.data_disk_linux]
}

resource "azurerm_managed_disk" "data_disk_windows" {
  name                 = var.windows_name
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = var.sa_type
  create_option        = var.option
  disk_size_gb         = var.disk_size
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "assignment1-attach-win" {
  managed_disk_id    = azurerm_managed_disk.data_disk_windows.id
  virtual_machine_id = var.windows_id
  lun                = "20"
  caching            = var.caching_type
  depends_on         = [azurerm_managed_disk.data_disk_windows]
}
