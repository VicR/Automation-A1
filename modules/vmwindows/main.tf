resource "azurerm_availability_set" "win_avs" {
  name                         = var.windows_avset
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                  = var.windows_name
  resource_group_name   = var.rg_name
  location              = var.location
  computer_name         = var.windows_name
  size                  = var.win_vm_size
  admin_username        = var.admin_user_name
  admin_password        = var.admin_password
  depends_on            = [azurerm_availability_set.win_avs]
  network_interface_ids = [azurerm_network_interface.win_nic.id]
  availability_set_id   = azurerm_availability_set.win_avs.id
  tags                  = var.tags

  winrm_listener {
    protocol = "Http"
  }

  os_disk {
    name                 = "${var.windows_name}-osdisk"
    storage_account_type = var.win_os_disk_attr["storage_account_type"]
    disk_size_gb         = var.win_os_disk_attr["disk_size"]
    caching              = var.win_os_disk_attr["disk_caching"]
  }

  source_image_reference {
    publisher = var.win_publisher
    offer     = var.win_offer
    sku       = var.win_sku
    version   = var.win_version
  }

  boot_diagnostics {
    storage_account_uri = var.sa_uri
  }
}

resource "azurerm_virtual_machine_extension" "windows_extension" {
  name                       = var.extension_name
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = "true"
  settings = <<SETTINGS
    {
      "AntimalwareEnabled": true,
      "RealtimeProtectionEnabled": "true",
      "ScheduledScanSettings": 
      {
        "isEnabled": "true",
        "day": "1",
        "time": "120",
        "scanType": "Quick"
      },
      "Exclusions": 
      {
        "Extensions": "",
        "Paths": "",
        "Processes": ""
      }
    }
  SETTINGS

  depends_on = [azurerm_windows_virtual_machine.windows_vm]
  tags       = var.tags
}

resource "azurerm_network_interface" "win_nic" {
  name                = "${var.windows_name}-nic"
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = "${var.windows_name}-ipconfig"
    public_ip_address_id          = azurerm_public_ip.win_public_ip.id
    private_ip_address_allocation = var.win_allocation_method
    subnet_id                     = var.subnet_id
  }
}

resource "azurerm_public_ip" "win_public_ip" {
  name                = var.win_pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.win_allocation_method
  domain_name_label   = var.win_dns
  depends_on          = [var.resource_group]
}
