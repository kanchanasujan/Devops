resource "azurerm_public_ip" "main" {
  count               = var.lb_type == "public" ? 1 : 0
  name                = "${var.component_name}-${var.env}-pip"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

data "azurerm_network_security_group" "existing" {
  count               =  var.lb_type == "public" ? 1 : 0
  name                = "network-grp"
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_network_interface_security_group_association" "global_assoc" {
  count                     = var.lb_type == "public" ? 1 : 0
  network_interface_id      = azurerm_network_interface.main[count.index].id
  network_security_group_id = data.azurerm_network_security_group.existing[count.index].id

  # Forces Terraform to wait until the VM instances are completely built
  depends_on = [ azurerm_linux_virtual_machine.main ]
}


resource "azurerm_lb" "main" {
  count               = var.lb_type != null ? 1 : 0
  name                = "${var.component_name}-${var.env}-lb"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  
  frontend_ip_configuration {
    name                          = "${var.component_name}-${var.env}"
    private_ip_address_allocation = var.lb_type == "private" ? "Dynamic" : null
    subnet_id                     = var.lb_type == "private" ? var.subnet_id: null
    public_ip_address_id          = var.lb_type == "public" ? azurerm_public_ip.main[0].id : null
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  count           = var.lb_type != null ? 1 : 0
  loadbalancer_id = azurerm_lb.main[0].id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "main" {
  count                               = var.lb_type != null ? 1 : 0
  name                                = "${var.component_name}-${var.env}-${count.index}"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.main[0].id
  ip_address                          = azurerm_network_interface.main[count.index].private_ip_address
  virtual_network_id                  = var.subnet_id
}

resource "azurerm_lb_probe" "main" {
  count = var.lb_type != null ? 1 : 0
  loadbalancer_id = azurerm_lb.main[0].id
  name            = "${var.component_name}-probe"
  protocol        = "Tcp"
  port            = var.port
}

resource "azurerm_lb_rule" "main" {
  count                          = var.lb_type != null ? 1 : 0
  loadbalancer_id                = azurerm_lb.main[0].id
  name                           = "${var.component_name}-rule"
  protocol                       = "Tcp"
  frontend_port                  = var.port
  backend_port                   = var.port
  frontend_ip_configuration_name = "${var.component_name}-${var.env}"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main[0].id]
  probe_id                       = azurerm_lb_probe.main[0].id
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = "${var.component_name}-${var.env}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  sku            = "Standard_B1ms"
  instances      = 2
  admin_username = "devops"
  admin_password = "Devops@12345"

  disable_password_authentication = false

  source_image_id = var.image_id

  secure_boot_enabled = true
  vtpm_enabled        = true

  upgrade_mode = "Automatic"

  user_data = base64encode(templatefile("${path.root}/userdata.sh", {
    component_name = var.component_name
    env            = var.env
  }))

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.component_name}-${var.env}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = var.lb_type != null ? [azurerm_lb_backend_address_pool.main[0].id] : null
    }
  }

  lifecycle {
    ignore_changes = [instances]
  }
}

resource "azurerm_dns_a_record" "main" {
  count = var.lb_type != null ? 1 : 0

  name                = "${var.component_name}-${var.env}"
  zone_name           = "kanchanadevisujan.online"
  resource_group_name = var.rgname
  ttl                 = 30
  records             = var.lb_type == "public" ? [azurerm_public_ip.main[0].ip_address] : [azurerm_lb.main[0].frontend_ip_configuration[0].private_ip_address]
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = "${var.component_name}-${var.env}-autoscale"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id

  profile {
    name = "default"

    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}