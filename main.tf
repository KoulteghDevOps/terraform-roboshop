module "vpc" {
  source = "git::https://github.com/KoulteghDevOps/tf_module_vpc.git"

  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]

  tags             = local.tags
  env              = var.env
  default_vpc_id   = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_rtid = var.default_vpc_rtid
}

# module "webserver" {
#   source = "git::https://github.com/KoulteghDevOps/tf_module_app.git"

#   for_each         = var.application
#   instance_type    = each.value["instance_type"]
#   name             = each.value["name"]
#   desired_capacity = each.value["desired_capacity"]
#   max_size         = each.value["max_size"]
#   min_size         = each.value["min_size"]


#   env          = var.env
#   bastion_cidr = var.bastion_cidr
#   tags         = local.tags

#   subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
#   vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
#   allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_app_cidr"], null), "subnet_cidrs", null)
# }

module "docdb" {
  source = "git::https://github.com/KoulteghDevOps/tf_module_docdb.git"

  for_each   = var.docdb
  subnets    = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
  engine_version = each.value["engine_version"]
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]

  tags             = local.tags
  env              = var.env
  vpc_id           = local.vpc_id
  allow_db_cidr    = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnet_cidrs", null)
  kms_arn          = var.kms_arn

}


