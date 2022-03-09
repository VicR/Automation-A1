variable "rg_name" {}
variable "location" {}
variable "linux_avset" {}
variable "linux_name" {}
variable "subnet_id" {}
variable "sa_uri" {}
variable "nb_count" {}
variable "resource_group" {}
variable "tags" {}

variable "public_key" {
  default = "/home/N01518013/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "/home/N01518013/.ssh/id_rsa"
}

variable "vm_size" {
  default = "Standard_B1ms"
}

variable "admin_user_name" {
  default = "victor8013"
}

variable "os_disk_attr" {
  type = map(string)
  default = {
    storage_account_type = "Standard_LRS"
    disk_size            = "32"
    disk_caching         = "ReadWrite"
  }
}
variable "extension_name" {
  default = "linux-watcher-8013"
}

variable "linux_allocation_method" {
  default = "Dynamic"
}

variable "linux_publisher" {
  default = "OpenLogic"
}

variable "linux_offer" {
  default = "CentOS"
}

variable "linux_sku" {
  default = "8_2"
}

variable "linux_version" {
  default = "latest"
}
