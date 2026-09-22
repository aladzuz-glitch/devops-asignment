output "resource_group_name" {
  value = azurerm_resource_group.devops_rg.name
}

output "service_plan_name" {
  value = azurerm_service_plan.devops_plan.name
}

output "web_app_name" {
  value = azurerm_linux_web_app.devops_app.name
}

output "web_app_hostname" {
  value = azurerm_linux_web_app.devops_app.default_hostname
}

output "resource_group_location" {
  value = azurerm_resource_group.devops_rg.location
}

output "environment" {
  value = var.environment
}

output "owner" {
  value = var.owner
}
output "web_app_url" {
  value = "https://${azurerm_linux_web_app.devops_app.default_hostname}"
}

output "application_insights_connection_string" {
  value     = azurerm_application_insights.appinsights.connection_string
  sensitive = true
}