module "resource_group_1" {
  source = "./modules/resource_groups"

  resource_group = resource_groups["rg1"]
  creator        = resource_groups["rg1"].creator
}

module "resource_group_2" {
  source = "./modules/resource_groups"

  resource_group = resource_groups["rg2"]
  creator        = resource_groups["rg2"].creator
}
module "resource_group_3" {
  source = "./modules/resource_groups"

  resource_group = resource_groups["rg3"]
  creator        = resource_groups["rg3"].creator
}

module "asp_1" {
  source   = "./modules/app_service_plan/"
  sp_name  = var.service_plans["sp1"].name
  rg       = resource_groups["rg1"]
  sku_type = var.service_plans["sp1"].sku_type
  creator  = var.creator
}
module "asp_2" {
  source   = "./modules/app_service_plan/"
  sp_name  = var.service_plans["sp2"].name
  rg       = resource_groups["rg2"]
  sku_type = var.service_plans["sp2"].sku_type
  creator  = var.creator
}


module "app_service_1" {
  source = "./modules/app_service/"

  app_name = var.app_services["sv1"].name
  rg       = var.resource_groups["rg1"]
  sp_id    = module.asp_1.sv_plan_id

  ip_restriction_rule_name = var.app_services["sv1"].ip_restr_rule_name
  allowed_ip               = var.app_services["sv1"].allowed_ip

  allow_tag_rule_name = var.app_services["sv1"].allow_tag_rule_name
  allowed_tag         = var.app_services["sv1"].allowed_tag
}
module "app_service_2" {
  source = "./modules/app_service/"

  app_name = var.app_services["sv2"].name
  rg       = var.resource_groups["rg2"]
  sp_id    = module.asp_2.sv_plan_id

  ip_restriction_rule_name = var.app_services["sv2"].ip_restr_rule_name
  allowed_ip               = var.app_services["sv2"].allowed_ip

  allow_tag_rule_name = var.app_services["sv2"].allow_tag_rule_name
  allowed_tag         = var.app_services["sv2"].allowed_tag
}
