resource "azurerm_public_ip" "assignment1_pip" {
  name                = var.lb_ip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "a1_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = var.ipconf_name
    public_ip_address_id = azurerm_public_ip.assignment1_pip.id
  }
  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "a1_backend_pool" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.a1_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "a1_pool_association" {
  count                   = length(var.linux_nics)
  ip_configuration_name   = element(var.linux_nics[*].ip_configuration[0].name, count.index)
  network_interface_id    = element(var.linux_nics[*].id, count.index)
  backend_address_pool_id = azurerm_lb_backend_address_pool.a1_backend_pool.id
}

resource "azurerm_lb_probe" "a1_lb_probe" {
  name                = var.probe_name
  resource_group_name = var.rg_name
  loadbalancer_id     = azurerm_lb.a1_lb.id
  port                = 22
}

resource "azurerm_lb_rule" "a1_lb_rule" {
  name                           = var.rule_name
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.a1_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.a1_lb.frontend_ip_configuration[0].name
}
