resource "azurerm_linux_virtual_machine_scale_set" "wordpress" {
  name                            = "vmscaleset"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.wordpress.name
  sku                             = "Standard_D2S_v3"
  instances                       = 1
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data = filebase64("customdata.sh")
  

admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }


 source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "latest"
  }


  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }


  network_interface {
    name    = "NetworkInterface"
    primary = true
    ip_configuration {
      name                                   = "subnet3"
      subnet_id                              = azurerm_subnet.subnet3.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      primary                                = true
    # public_ip_address {
    #   name = "PubIP"
    #   }
      }
    }


    tags = var.tags
}


 