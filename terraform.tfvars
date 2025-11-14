aws_region = "us-east-1"
project_name = "simple-notatnik"

vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

# Fargate - Docker images - ZAMIEŃ NA SWOJE ECR IMAGE URI
frontend_image = "375473503565.dkr.ecr.us-east-1.amazonaws.com/notatnik/frontend:latest"
backend_image  = "375473503565.dkr.ecr.us-east-1.amazonaws.com/notatnik/backend:latest"

# Opcjonalne - dostosuj porty i zasoby
frontend_port    = 80
backend_port     = 8080
frontend_cpu     = 256
frontend_memory  = 512
backend_cpu      = 256
backend_memory   = 512
frontend_replicas = 2
backend_replicas  = 2

# RDS PostgreSQL configuration
db_name                = "notepad"
db_username            = "postgres"
db_password            = "postgres" 
db_allocated_storage   = 20
db_instance_class      = "db.t3.micro"
backup_retention_days  = 7
multi_az               = false

# IAM Role ARN dla ECS (zamień ACCOUNT_ID na 375473503565)
ecs_task_execution_role_arn = "arn:aws:iam::375473503565:role/LabRole"