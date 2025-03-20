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

  ip_restriction_rule_name = each.value.ip_restr_rule_name
  allowed_ip               = each.value.allowed_ip

  allow_tag_rule_name = each.value.allow_tag_rule_name
  allowed_tag         = each.value.allowed_tag
  creator             = var.creator
}

module "traffic_manager" {
  source = "./modules/traffic_manager/"

  profile_name   = var.tm.profile_name
  rg             = module.rg["rg3"].name
  routing_method = var.tm.routing_method
  app_services   = module.app_service
  creator        = var.creator
}
