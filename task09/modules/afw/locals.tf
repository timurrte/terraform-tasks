locals {
  pip_name      = join("-", [var.name_prefix, "pip"])
  afw_name      = join("-", [var.name_prefix, "afw"])
  rt_name       = join("-", [var.name_prefix, "rt"])
  app_rule_name = join("-", [var.name_prefix, "app-rule"])
  net_rule_name = join("-", [var.name_prefix, "net-rule"])
  nat_rule_name = join("-", [var.name_prefix, "nat-rule"])
}
