resource "azurerm_container_registry" "acr" {
  name                = "ajdindevopsacr"
  resource_group_name = "rg-devops-iac"
  location            = "swedencentral"
  sku                 = "Basic"
  admin_enabled       = true
}