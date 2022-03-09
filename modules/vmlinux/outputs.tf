output "linux_vm_hostnames" {
  value = azurerm_linux_virtual_machine.linux_vm.*.name
}

output "linux_vm_ids" {
  value = azurerm_linux_virtual_machine.linux_vm.*.id
}

output "linux_private_ips" {
  value = azurerm_linux_virtual_machine.linux_vm.*.private_ip_address
}

output "linux_public_ips" {
  value = azurerm_linux_virtual_machine.linux_vm.*.public_ip_address
}

output "linux_nics" {
  value = azurerm_network_interface.linux_nic[*]
}
