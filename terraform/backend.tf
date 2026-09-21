terraform {

  backend "azurerm" {

    resource_group_name  = "rg-devops-iac"

    storage_account_name = "ajtfstate2026"

    container_name       = "tfstate"

    key                  = "terraform.tfstate"
  }
}