variable "rg_name" {}
variable "windows_avset" {}
variable "windows_name" {}
variable "resource_group" {}
variable "location" {}
variable "subnet_id" {}
variable "sa_uri" {}
variable "tags" {}

variable "win_vm_size" {
  default = "Standard_B1ms"
}

variable "admin_user_name" {
  default = "victor8013"
}

variable "admin_password" {
  default = "P@$$w0rd1234!"
}

variable "public_key" {
  default = "/home/N01518013/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "/home/N01518013/.ssh/id_rsa"
}

variable "win_os_disk_attr" {
  type = map(string)
  default = {
    storage_account_type = "Standard_LRS"
    disk_size            = "127"
    disk_caching         = "ReadWrite"
  }
}

variable "extension_name" {
  default = "win-antimalware-8013"
}

variable "win_allocation_method" {
  default = "Dynamic"
}

variable "win_pip_name" {
  default = "win-pip-8013"
}
variable "win_dns" {
  default = "win-vm-a1"
}
variable "win_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "win_offer" {
  default = "WindowsServer"
}

variable "win_sku" {
  default = "2016-Datacenter"
}

variable "win_version" {
  default = "latest"
}
