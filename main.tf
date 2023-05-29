module "vpc" {
  source = "git::https://github.com/KoulteghDevOps/tf_module_vpc.git"
  
  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags       = local.tags
  env        = var.env
}

module "webserver" {
  source = "git::https://github.com/KoulteghDevOps/tf_module_app.git"

  for_each = var.application
  instance_type = each.value["instance_type"]
  subnet_id = element(lookup(lookup(lookup(module.vpc, "main", null), each.value["subnet_name"], null), "subnet_ids", null), 0)
}