module "spn" {
  source    = "../.."
  myspns    = local.myspns
  role_defs = local.role_defs
}