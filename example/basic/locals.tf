locals {
  myspns = {
    azure-autoscaling = {
      application_name             = "azure-autoscaling"
      identifier_uris              = ["https://azure-autoscaling"]
      application_secret           = ""
      end_date_relative            = "26280h" # 3 Years
      app_role_assignment_required = true
      role_definition_name         = "Contributor"
    }
    nsxt-azure-lab = {
      application_name             = "nsxt-azure-lab"
      identifier_uris              = ["https://nsxt-azure-lab"]
      application_secret           = ""
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
