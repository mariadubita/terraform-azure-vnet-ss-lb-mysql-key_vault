resource "random_string" "random" {
  length           = 12
  special          = false
  override_special = "/@£$"
  lower            = true 
  upper            = false 
  numeric          = false
}

# Create MySQL Server
resource "azurerm_mysql_server" "wordpress" {
  resource_group_name = azurerm_resource_group.wordpress.name
  name                = "wordpress-${random_string.random.result}"
  location            = azurerm_resource_group.wordpress.location
  version             = "5.7"
  administrator_login          = var.database_admin_login
  administrator_login_password = var.database_admin_password
  sku_name                     = "GP_Gen5_4"
  storage_mb                   = "102400"
  auto_grow_enabled            = false
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Create MySql DataBase
resource "azurerm_mysql_database" "wordpress" {
  name                = var.dbname
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_server.wordpress.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "wordpress" {
  name                = "wordpress-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_server.wordpress.name
  start_ip_address    = azurerm_public_ip.wordpress.ip_address
  end_ip_address      = azurerm_public_ip.wordpress.ip_address
}

# This allows MySQL access to Azure Resources
resource "azurerm_mysql_firewall_rule" "wordpress2" {
  name                = "wordpress2-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_server.wordpress.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

data "azurerm_mysql_server" "wordpress" {
  name                = azurerm_mysql_server.wordpress.name
  resource_group_name = azurerm_resource_group.wordpress.name
}
