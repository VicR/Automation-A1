module "rgroup" {
  source    = "./modules/rgroup"
  rg_name   = "8013-assignment1-RG"
  location  = "CanadaCentral"
  tags      = local.common_tags
}

module "common" {
  source     = "./modules/common"
  law_name   = "assignment1-law-8013"
  rsv_name   = "assignment1-rsv-8013"
  sa_name    = "assignment1sa8013"
  rg_name    = module.rgroup.a1_rg.name
  location   = module.rgroup.a1_rg.location
  tags       = local.common_tags
  resource_group = module.rgroup.a1_rg
  depends_on = [module.rgroup]   
}

module "network" {
  source        = "./modules/network"
  rg_name       = module.rgroup.a1_rg.name
  location      = module.rgroup.a1_rg.location
  vnet_name     = "vnet-8013"
  vnet_space    = ["10.0.0.0/16"]
  subnet_name   = "subnet-8013"
  subnet_space  = ["10.0.1.0/24"]
  tags          = local.common_tags
  depends_on    = [module.rgroup]
}

module "vmlinux" {
  source         = "./modules/vmlinux"
  rg_name        = module.rgroup.a1_rg.name
  linux_name     = "linux-vm-8013"
  linux_avset    = "linux-avs-8013"
  resource_group = module.rgroup.a1_rg
  location       = module.rgroup.a1_rg.location
  subnet_id      = module.network.subnet_id
  sa_uri         = module.common.sa_uri
  nb_count       = 2
  tags           = local.common_tags
  depends_on     = [module.network]
}

module "vmwindows" {
  source        = "./modules/vmwindows"
  rg_name       = module.rgroup.a1_rg.name
  windows_avset = "windows-avs-8013"
  windows_name  = "windows-vm-8013"
  resource_group = module.rgroup.a1_rg
  location       = module.rgroup.a1_rg.location
  subnet_id      = module.network.subnet_id
  sa_uri         = module.common.sa_uri
  tags           = local.common_tags
  depends_on     = [module.network]
}

module "datadisk" {
  source        = "./modules/datadisk"
  rg_name       = module.rgroup.a1_rg.name
  location      = module.rgroup.a1_rg.location
  linux_names   = module.vmlinux.linux_vm_hostnames
  linux_ids     = module.vmlinux.linux_vm_ids
  windows_name  = module.vmwindows.windows_vm_hostname
  windows_id    = module.vmwindows.windows_vm_id
  tags          = local.common_tags
  nb_count      = 2
  depends_on = [
    module.vmlinux,
    module.vmwindows
  ]
}

module "loadbalancer" {
  source      = "./modules/loadbalancer"
  lb_name     = "a1-lb-8013"
  lb_ip_name  = "a1-lb-pip-8013"
  location    = module.rgroup.a1_rg.location
  rg_name     = module.rgroup.a1_rg.name
  subnet_id   = module.network.subnet_id
  linux_nics  = module.vmlinux.linux_nics
  tags        = local.common_tags
  depends_on  = [module.vmlinux]
}

module "database" {
  source      = "./modules/database"
  db_name     = "a1-postgres-db-8013"
  server_name = "a1-postgres-server-8013"
  rg_name     = module.rgroup.a1_rg.name
  location    = module.rgroup.a1_rg.location
  tags        = local.common_tags
  depends_on  = [module.loadbalancer]   
}
