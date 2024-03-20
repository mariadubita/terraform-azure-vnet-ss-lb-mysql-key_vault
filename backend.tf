terraform {
  backend "azurerm" {
        resource_group_name  = "cloud-shell-storage" #resource resource_group_name created manually 
        storage_account_name = "your_storage_account_name"     # created manually
        container_name       = "your_container_name"
        key                  = "wordpress.tfstate"
    }
}