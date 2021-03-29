terraform {
  required_version = "~> 0.14.0"

  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "~> 2.53.0"
    }
  }
}

provider "azure" {
  features {}
}

resource "azurerm_resource_group" "admin_project" {
  name     = var.resource_group
  location = var.region
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = "tf-storage-account"
  resource_group_name      = azurerm_resource_group.admin_project.name
  location                 = azurerm_resource_group.admin_project.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tf-state-container"
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}