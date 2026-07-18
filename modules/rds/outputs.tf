output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_arn" {
  value = aws_db_instance.this.arn
}

output "database_name" {
  value = aws_db_instance.this.db_name
}

output "subnet_group_name" {
  value = aws_db_instance.this.db_subnet_group_name
}

output "security_group_id" {
  value = aws_db_instance.this.vpc_security_group_ids
}