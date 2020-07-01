output "azuread_service_principal_id_map" {
  value = module.spn.azuread_service_principal_id_map
}

output "subscription_details" {
  value = module.spn.current_subscription
}

output "azuread_service_principal_secret_map" {
  value = module.spn.azuread_service_principal_secret_map
}