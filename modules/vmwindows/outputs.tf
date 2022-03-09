output "windows_vm_hostname" {
  value = azurerm_windows_virtual_machine.windows_vm.name
}

output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.windows_vm.id
}

output "windows_private_ip" {
  value = azurerm_windows_virtual_machine.windows_vm.private_ip_address
}

output "windows_public_ip" {
  value = azurerm_windows_virtual_machine.windows_vm.public_ip_address
}
