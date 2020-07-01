# Azure Service Principal Module

This module can generate unlimited service prinicpals, and a role defintions.

## Requirements

| Name | Version |
|------|---------|
| azuread | 0.9.0 |
| azurerm | 2.11.0 |

## Providers

| Name | Version |
|------|---------|
| azuread | 0.9.0 |
| azurerm | 2.11.0 |

## Usage
````hcl-terraform
module "spn" {
  source    = "git::https://spring.paloaltonetworks.com/acoleman/terraform-azure-spn?ref=v0.1.0"
  myspns    = local.myspns
  role_defs = local.role_defs
}
````

## Inputs on locals.tf

| data_map | key | value(example)| type | required? |description|
|----------|-----|---------------|------|-----------|-----------|
| myspns |application_name | "your_app_name" |string | yes| This is the service principal application name you are choosing to set|
| myspns |identifier_uris | ["https://your-app-name"]|list(string) | yes | This is the SPN URI, you can pretty much make this what you want as long as it is unique|
| myspns |application_secret | "yourappsecret" |string | yes | This is the secret key you are setting for your SPN, think of this as a password. I suggest pulling this value dynamiically from a secrets manager like vault.|
| myspns |end_date_relative | "26280h"|string | yes | Number of hours before secret expires |
| myspns |app_role_assignment_required|"Contributor" |string | yes | This can be the built-in roles such as Contributor or a custom role name
| role_defs | (name of role) | ["Microsoft.Compute/virtualMachines/read"] | list(string) | no | Generates custom role from supplied name and permissions

## Outputs

| Name | Description |
|------|-------------|
| azuread\_service\_principal\_id\_map | Service Principal Name to ID Mapping |
| azuread\_service\_principal\_secret\_map | Service Principal Secret to ID Mapping |
| current\_subscription | Subscription Details |

