provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "devops-project-2026-rg"
  location = "East US"
}

resource "azurerm_container_group" "web" {
  name                = "my-website-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = "creative-web-2026" # Must be globally unique

  container {
    name   = "web-server"
    image  = "ghcr.io/democloudarun/my-azure-website:latest"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
