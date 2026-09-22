resource "azurerm_application_insights" "appinsights" {
  name                = "appi-devops-iac"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  application_type    = "web"
}