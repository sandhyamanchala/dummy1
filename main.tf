terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.0"
    }
  }

# use this command while initializing the backend---->terraform init -backend-config="access_key=B3VYb3NDj9Sgk+kDLnzK6PFCpNn5lBjE+7/VVbHrO2MyrIZYgL9bu1r1jidsk4tSzkg+QdYsLLhkn9IcPWeIEw=="
  backend "azurerm" {
        resource_group_name  = "firstRG"
        storage_account_name = "hvgfhvgdh32323" 
        container_name       = "container11"
        key                  = "myterraform.tfstate"
        access_key  = "B3VYb3NDj9Sgk+kDLnzK6PFCpNn5lBjE+7/VVbHrO2MyrIZYgL9bu1r1jidsk4tSzkg+QdYsLLhkn9IcPWeIEw=="
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
      subscription_id="2a09dc82-04ad-4375-9ab1-aec34588d536"
      tenant_id="e6a653a2-0e0b-45b0-96d6-a4fa6f0e7950"
      client_id="e1c17412-d14f-4721-96b1-72f0ba002bb5"
      client_secret="R2-7Q~HdqJNvOf5XcDK_zrQXz3HS1c888wpJe"

}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location_name
  address_space       = var.vnet_addr

}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.2.1.0/24"]

}

resource "azurerm_storage_account" "example" {
  name                     = "hvgfhvgdh32323"
  resource_group_name      = var.resource_group_name
  location                 = var.location_name
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "stagingdev"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "container11"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
