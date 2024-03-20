resource "random_string" "random_name" {
  length           = 14
  special          = false
  override_special = "/@£$"
  upper            = false
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "wordpress" {
  name = azurerm_key_vault.wordpress.name
  resource_group_name = azurerm_resource_group.wordpress.name
}


resource "azurerm_key_vault" "wordpress" {
  name                        = "wp-${random_string.random_name.result}"
  location                    = azurerm_resource_group.wordpress.location
  resource_group_name         = azurerm_resource_group.wordpress.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
    ]
    
    storage_permissions = [
      "Get",
      "List",
      "Update",
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers"
    ]
  }
  
  enabled_for_template_deployment = true
  enabled_for_deployment = true
}