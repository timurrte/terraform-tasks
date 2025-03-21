module "rg" {
  for_each = var.resource_groups
  source   = "./modules/resource_group/"

  resource_group = each.value
  creator        = var.creator
}

module "asp" {
  for_each       = var.service_plans
  source         = "./modules/app_service_plan/"
  sp_name        = each.value.name
  rg             = module.rg[each.value.rg_key].name
  sku_type       = each.value.sku_type
  instance_count = each.value.instance_count
  creator        = var.creator
}

module "app_service" {
  for_each = var.app_services
  source   = "./modules/app_service/"

  app_name = each.value.name
  rg       = module.rg[each.value.rg_key].name
  sp_id    = module.asp[each.value.sp_key].sv_plan_id

  ip_rules = var.ip_rules

  creator = var.creator
}

module "traffic_manager" {
  for_each = var.traf
  source   = "./modules/traffic_manager/"

  profile_name   = each.value.profile_name
  rg             = module.rg["rg3"].name
  routing_method = each.value.routing_method
  app_services = {
    sv2 = {
      name = module.app_service["sv1"].name,
      id   = module.app_service["sv1"].id
    },
    sv1 = {
      name = module.app_service["sv2"].name,
      id   = module.app_service["sv2"].id
  } }
  creator = var.creator
}
