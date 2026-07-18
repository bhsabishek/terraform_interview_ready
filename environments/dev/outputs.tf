output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_arn" {
  value = module.rds.rds_arn
}

output "database_name" {
  value = module.rds.database_name
}

output "subnet_group_name" {
  value = module.rds.subnet_group_name
}

output "security_group_id" {
  value = module.rds.security_group_id
}
