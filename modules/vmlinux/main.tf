resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avset
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                 = var.nb_count
  name                  = "${var.linux_name}-${format("%1d", count.index + 1)}"
  resource_group_name   = var.rg_name
  location              = var.location
  computer_name         = "${var.linux_name}-${format("%1d", count.index + 1)}"
  size                  = var.vm_size
  admin_username        = var.admin_user_name
  depends_on            = [azurerm_availability_set.linux_avs]
  availability_set_id   = azurerm_availability_set.linux_avs.id
  network_interface_ids = [element(azurerm_network_interface.linux_nic[*].id, count.index + 1)]
  tags = var.tags

  admin_ssh_key {
    username   = var.admin_user_name
    public_key = file(var.public_key)
  }

  os_disk {
    name                 = "${var.linux_name}-osdisk-${format("%1d", count.index + 1)}"
    storage_account_type = var.os_disk_attr["storage_account_type"]
    disk_size_gb         = var.os_disk_attr["disk_size"]
    caching              = var.os_disk_attr["disk_caching"]
  }

  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }

  boot_diagnostics {
    storage_account_uri = var.sa_uri
  }
}

resource "azurerm_virtual_machine_extension" "linux_extension" {
  count                = var.nb_count
  name                 = var.extension_name
  virtual_machine_id   = element(azurerm_linux_virtual_machine.linux_vm[*].id, count.index + 1)
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  auto_upgrade_minor_version = "true"
  # settings = <<SETTINGS
  #   {
  #       "commandToExecute": "hostname && uptime"
  #   }
  # SETTINGS
  tags        = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}-nic-${format("%1d", count.index + 1)}"
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig-${format("%1d", count.index + 1)}"
    public_ip_address_id          = element(azurerm_public_ip.linux_public_ip[*].id, count.index + 1)
    private_ip_address_allocation = var.linux_allocation_method
    subnet_id                     = var.subnet_id
  }
}

resource "azurerm_public_ip" "linux_public_ip" {
  count               = var.nb_count
  name                = "${var.linux_name}-pip-${format("%1d", count.index + 1)}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.linux_allocation_method
  domain_name_label   = "${var.linux_name}${format("%1d", count.index + 1)}"
  depends_on          = [var.resource_group]
}
