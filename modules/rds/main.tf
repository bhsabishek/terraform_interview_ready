resource "aws_db_instance" "this" {
  db_name             = var.db_name
  engine              = var.engine
  instance_class      = var.instance_class
  storage_type        = var.storage_type
  allocated_storage   = var.allocated_storage
  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible
  deletion_protection = var.deletion_protection
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = var.skip_final_snapshot

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-subnet-group"
    Environment = var.environment
  }
}