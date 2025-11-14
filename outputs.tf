output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID sieci VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Identyfikatory publicznych podsieci"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Identyfikatory prywatnych podsieci"
}

# Fargate outputs
output "alb_dns_name" {
  value       = module.fargate.alb_dns_name
  description = "DNS nazwa Load Balancera - użyj tego aby dostać się do aplikacji!"
}

output "ecs_cluster_name" {
  value       = module.fargate.ecs_cluster_name
  description = "Nazwa ECS Cluster"
}

output "frontend_service_name" {
  value       = module.fargate.frontend_service_name
  description = "Nazwa Frontend ECS Service"
}

output "backend_service_name" {
  value       = module.fargate.backend_service_name
  description = "Nazwa Backend ECS Service"
}

output "cloudwatch_log_group" {
  value       = module.fargate.cloudwatch_log_group
  description = "CloudWatch Log Group dla ECS logs"
}

# RDS outputs
output "db_endpoint" {
  value       = module.rds.db_endpoint
  description = "RDS Database endpoint (host:port)"
}

output "db_host" {
  value       = module.rds.db_host
  description = "RDS Database host"
}

output "db_port" {
  value       = module.rds.db_port
  description = "RDS Database port"
}

output "db_name" {
  value       = module.rds.db_name
  description = "RDS Database name"
}

output "db_username" {
  value       = module.rds.db_username
  description = "RDS Database username"
}