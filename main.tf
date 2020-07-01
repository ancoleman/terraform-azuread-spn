/**
 * # Azure Service Principal Data Structure for locals.tf
 *
 * Everything in this comment block will get extracted.
 *
 * You can put simple text or complete Markdown content
 * here. Subsequently if you want to render AsciiDoc format
 * you can put AsciiDoc compatible content in this comment
 * block.
 */

provider "azuread" {
  version = "0.9.0"
}
provider "azurerm" {
  features {}
  version = "2.11.0"
}

locals {
  myspns = {
    azure-autoscaling = {
      application_name             = "anc-azureautoscaling"
      identifier_uris              = ["https://anc-azureautoscaling"]
      application_secret           = "AncP@l04321!$$$!~"
      end_date_relative            = "26280h" # 3 Years
      app_role_assignment_required = true
      role_definition_name         = "Contributor"
    }
    nsxt-azure-lab = {
      application_name             = "nsxt-azure-lab"
      identifier_uris              = ["https://nsxt-azure-lab"]
      application_secret           = "AncP@l04321!!~"
      end_date_relative            = "26280h" # 3 Years
      app_role_assignment_required = true
      role_definition_name         = "Reader"
    }
  }
  role_defs = {
    pan_app_insights = ["Microsoft.Authorization/*/read", "Microsoft.Network/networkInterfaces/*",
    "Microsoft.Network/networkSecurityGroups/*", "Microsoft.Network/virtualNetworks/*", "Microsoft.Compute/virtualMachines/read"]
    pan_autoscaling = ["Microsoft.Network/virtualNetworks/read", "Microsoft.Network/routeTables/read", "Microsoft.Network/loadBalancers/read",
      "Microsoft.Insights/components/read", "Microsoft.Network/publicIPAddresses/read", "Microsoft.Network/applicationGateways/read",
    "Microsoft.Compute/virtualMachineScaleSets/read", "Microsoft.Insights/autoscalesettings/read"]
    pan_vm_monitoring = ["Microsoft.Compute/virtualMachines/read", "Microsoft.Network/networkInterfaces/read", "Microsoft.Network/virtualNetworks/read"]
    pan_ha = ["Microsoft.Authorization/*/read", "Microsoft.Network/networkInterfaces/*", "Microsoft.Network/networkSecurityGroups/*", "Microsoft.Network/virtualNetworks/*",
    "Microsoft.Compute/virtualMachines/read"]
  }
}

resource "azuread_application" "custom" {
  for_each        = local.myspns
  name            = each.value.application_name
  identifier_uris = each.value.identifier_uris
}

resource "azuread_application_password" "custom" {
  for_each              = local.myspns
  value                 = each.value.application_secret
  application_object_id = azuread_application.custom[each.key].id
  end_date_relative     = each.value.end_date_relative
}

resource "azuread_service_principal" "custom" {
  for_each                     = local.myspns
  application_id               = azuread_application.custom[each.key].application_id
  app_role_assignment_required = each.value.app_role_assignment_required
}

resource "azurerm_role_assignment" "custom" {
  for_each             = local.myspns
  principal_id         = azuread_service_principal.custom[each.key].id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.value.role_definition_name
}

resource "azurerm_role_definition" "this" {
  for_each = local.role_defs
  assignable_scopes = [data.azurerm_subscription.current.id, ]
  name              = each.key
  scope             = data.azurerm_subscription.current.id
  description       = "Palo Alto Networks Required Permissions"
  permissions {
    actions = each.value
  }
}