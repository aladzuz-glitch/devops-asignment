resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-devops-iac"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name

  address_space = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "integration" {
  name                 = "snet-integration"
  resource_group_name  = azurerm_resource_group.devops_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.10.1.0/24"]

  delegation {
    name = "webapp"

    service_delegation {
      name = "Microsoft.Web/serverFarms"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-private-endpoint"
  resource_group_name  = azurerm_resource_group.devops_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.10.2.0/24"]
}

resource "azurerm_app_service_virtual_network_swift_connection" "integration" {
  app_service_id = azurerm_linux_web_app.devops_app.id
  subnet_id      = azurerm_subnet.integration.id
}

resource "azurerm_private_dns_zone" "webapp" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.devops_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "webapp" {
  name                  = "webapp-dns-link"
  resource_group_name   = azurerm_resource_group.devops_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.webapp.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "webapp" {
  name                = "pe-webapp"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name

  subnet_id = azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "webapp-private-connection"
    private_connection_resource_id = azurerm_linux_web_app.devops_app.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "webapp-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.webapp.id]
  }
}