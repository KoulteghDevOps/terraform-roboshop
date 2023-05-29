# output "vpc" {
#   value = module.vpc
# }

output "vpc" {
  value = lookup(module.vpc, "main", null)
}