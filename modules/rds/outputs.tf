output "db_endpoint" {
  value       = aws_db_instance.postgres.endpoint
  description = "RDS Database endpoint (host:port)"
}

output "db_host" {
  value       = aws_db_instance.postgres.address
  description = "RDS Database host"
}

output "db_port" {
  value       = aws_db_instance.postgres.port
  description = "RDS Database port"
}

output "db_name" {
  value       = aws_db_instance.postgres.db_name
  description = "RDS Database name"
}

output "db_username" {
  value       = var.db_username
  description = "RDS Database username"
}

output "db_resource_id" {
  value       = aws_db_instance.postgres.resource_id
  description = "RDS Database resource ID"
}

output "connection_string" {
  value       = "postgresql://${var.db_username}:PASSWORD@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${var.db_name}"
  description = "PostgreSQL connection string (zamień PASSWORD na rzeczywiste hasło)"
}
