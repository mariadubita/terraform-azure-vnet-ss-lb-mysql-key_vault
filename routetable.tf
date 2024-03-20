resource "azurerm_route_table" "wordpress" {
  name                          = "wordpress-route-table"
  location                      = azurerm_resource_group.wordpress.location
  resource_group_name           = azurerm_resource_group.wordpress.name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "10.0.1.0/24"
    next_hop_type  = "VnetLocal"
  }
}

resource "azurerm_subnet_route_table_association" "wordpress" {
  subnet_id      = azurerm_subnet.subnet3.id
  route_table_id = azurerm_route_table.wordpress.id
}