output "current_subscription" {
  value = {
    name      = data.azurerm_subscription.current.display_name
    sub_id    = data.azurerm_subscription.current.id
    tenant_id = data.azurerm_subscription.current.tenant_id
    state     = data.azurerm_subscription.current.state
    spend     = data.azurerm_subscription.current.spending_limit
  }
  description = "Subscription Details"
}

output "azuread_service_principal_id_map" {
  value = { for i in azuread_application.custom :
    i.name => i.application_id
  }
  description = "Service Principal Name to ID Mapping"
}

output "azuread_service_principal_secret_map" {
  value = { for i in azuread_application_password.custom :
    i.id => i.value
  }
  description = "Service Principal Secret to ID Mapping"
}