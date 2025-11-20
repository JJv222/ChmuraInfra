aws_region = "us-east-1"
project_name = "simple-notatnik"

vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet = "10.0.10.0/24"

# Fargate 
frontend_image = "375473503565.dkr.ecr.us-east-1.amazonaws.com/notatnik/frontend:latest"
backend_image  = "375473503565.dkr.ecr.us-east-1.amazonaws.com/notatnik/backend:latest"

# Opcjonalne - dostosuj porty i zasoby
frontend_port    = 80
backend_port     = 8080
frontend_replicas = 1
backend_replicas  = 1

# RDS PostgreSQL configuration
db_name                = "notepad"
db_username            = "postgres"
db_password            = "postgres" 

# IAM Role ARN dla ECS
ecs_task_execution_role_arn = "arn:aws:iam::375473503565:role/LabRole"