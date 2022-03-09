variable db_name {}
variable server_name {}
variable rg_name {}
variable location {}
variable tags {}

variable "server_sku" {
  default = "B_Gen5_2"
}

variable "db_username" {
  default = "psqladmin8013"
}

variable "db_password" {
  default = "H@Sh1CoR3!"
}

variable "db_version" {
  default = "9.5"
}
