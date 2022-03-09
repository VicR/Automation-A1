output "rg_name" {
  value = module.rgroup.a1_rg.name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "linux_vm_hostnames" {
  value = module.vmlinux.linux_vm_hostnames
}

output "linux_private_ips" {
  value = module.vmlinux.linux_private_ips
}

output "linux_public_ips" {
  value = module.vmlinux.linux_public_ips
}

output "windows_vm_hostname" {
  value = module.vmwindows.windows_vm_hostname
}

output "windows_private_ip" {
  value = module.vmwindows.windows_private_ip
}

output "windows_public_ip" {
  value = module.vmwindows.windows_public_ip
}

output "law_name" {
  value = module.common.law_name
}

output "rsv_name" {
  value = module.common.rsv_name
}

output "sa_name" {
  value = module.common.sa_name
}

output "load_balancer_name" {
  value = module.loadbalancer.load_balancer_name
}

output "db_name" {
  value = module.database.db_name
}
