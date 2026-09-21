resource "azurerm_resource_group" "devops_rg" {

  name     = "rg-devops-iac"
  location = var.location

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_service_plan" "devops_plan" {

  name                = "asp-devops-iac"
  resource_group_name = azurerm_resource_group.devops_rg.name
  location            = azurerm_resource_group.devops_rg.location

  os_type  = "Linux"
  sku_name = "F1"

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_linux_web_app" "devops_app" {

  name                = "ajdin-devops-iac-app"
  resource_group_name = azurerm_resource_group.devops_rg.name
  location            = azurerm_resource_group.devops_rg.location
  service_plan_id     = azurerm_service_plan.devops_plan.id

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }


  site_config {
    always_on = false
  }


  app_settings = {
    APP_ENV     = var.environment
    APP_OWNER   = var.owner
    APP_VERSION = var.app_version
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "ajtfstate2026"
  resource_group_name      = azurerm_resource_group.devops_rg.name
  location                 = azurerm_resource_group.devops_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}
