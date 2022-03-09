variable "rg_name" {}
variable "location" {}
variable "linux_names" {}
variable "linux_ids" {}
variable "windows_name" {}
variable "windows_id" {}
variable "nb_count" {}
variable "tags" {}

variable "sa_type" {
  default = "Standard_LRS"
}

variable "disk_size" {
  default = "10"
}

variable "option" {
  default = "Empty"
}

variable "caching_type" {
  default = "ReadWrite"
}
