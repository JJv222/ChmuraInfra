output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "DNS nazwa Application Load Balancera - użyj tego aby dostać się do aplikacji"
}

output "alb_arn" {
  value       = aws_lb.main.arn
  description = "ARN Application Load Balancera"
}

output "frontend_target_group_arn" {
  value       = aws_lb_target_group.frontend.arn
  description = "ARN Target Group dla Frontend"
}

output "backend_target_group_arn" {
  value       = aws_lb_target_group.backend.arn
  description = "ARN Target Group dla Backend"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "Nazwa ECS Cluster"
}

output "frontend_service_name" {
  value       = aws_ecs_service.frontend.name
  description = "Nazwa Frontend ECS Service"
}

output "backend_service_name" {
  value       = aws_ecs_service.backend.name
  description = "Nazwa Backend ECS Service"
}

output "cloudwatch_log_group" {
  value       = aws_cloudwatch_log_group.ecs.name
  description = "CloudWatch Log Group dla ECS logs"
}

output "ecs_security_group_id" {
  value       = aws_security_group.ecs_tasks.id
  description = "Security Group ID dla ECS tasks (do użytku z RDS)"
}
