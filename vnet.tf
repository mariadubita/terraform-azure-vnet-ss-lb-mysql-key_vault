# Create a virtual network within the resource group

resource "azurerm_virtual_network" "wordpress" {
 name               = "wordpress-vnet"
 address_space      = ["10.0.0.0/16"]
 location           = var.location
 resource_group_name = azurerm_resource_group.wordpress.name
 tags               = var.tags
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "wordpress" {
  name                = "wordpress-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name
  allocation_method   = "Static"
  # domain_name_label   = random_string.fqdn.result
  tags                = var.tags
}

resource "aws_route53_record" "wordpressdb" {
  zone_id = "your_zone_id"
  name    = "wordpressdb.yourdomain.com"
  type    = "A"
  ttl     = 300
  records = [azurerm_public_ip.wordpress.ip_address]
}

resource "azurerm_network_interface" "wordpress" {
  name                = "wordpress-azureteam"
  location            = azurerm_resource_group.wordpress.location
  resource_group_name = azurerm_resource_group.wordpress.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet3.id
    private_ip_address_allocation = "Dynamic"
  }
}