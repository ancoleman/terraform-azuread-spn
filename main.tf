provider "azuread" {
  version = "0.9.0"
}
provider "azurerm" {
  features {}
  version = "2.11.0"
}

resource "azuread_application" "custom" {
  for_each        = var.myspns
  name            = each.value.application_name
  identifier_uris = each.value.identifier_uris
}

resource "azuread_application_password" "custom" {
  for_each              = var.myspns
  value                 = each.value.application_secret
  application_object_id = azuread_application.custom[each.key].id
  end_date_relative     = each.value.end_date_relative
}

resource "azuread_service_principal" "custom" {
  for_each                     = var.myspns
  application_id               = azuread_application.custom[each.key].application_id
  app_role_assignment_required = each.value.app_role_assignment_required
}

resource "azurerm_role_assignment" "custom" {
  for_each             = var.myspns
  principal_id         = azuread_service_principal.custom[each.key].id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.value.role_definition_name
}

resource "azurerm_role_definition" "this" {
  for_each          = var.role_defs
  assignable_scopes = [data.azurerm_subscription.current.id, ]
  name              = each.key
  scope             = data.azurerm_subscription.current.id
  description       = "Palo Alto Networks Required Permissions"
  permissions {
    actions = each.value
  }
}