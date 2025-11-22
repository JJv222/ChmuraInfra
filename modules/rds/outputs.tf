output "db_endpoint" {
  value       = aws_db_instance.postgres.endpoint
  description = "RDS Database endpoint (host:port)"
}

output "db_resource_id" {
  value       = aws_db_instance.postgres.resource_id
  description = "RDS Database resource ID"
}

output "connection_string" {
  value       = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${var.project_name}-rds-sg"
  description = "PostgreSQL connection string "
}
