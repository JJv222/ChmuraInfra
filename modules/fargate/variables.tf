variable "project_name" {
  type        = string
  description = "Nazwa projektu"
}

variable "vpc_id" {
  type        = string
  description = "ID sieci VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Lista ID publicznych podsieci dla Load Balancera"
}

variable "s3_name" {
  type        = string
  description = "Nazwa istniejącego bucketu S3 do przechowywania plików statycznych frontend"
}

variable "private_subnet_id" {
  type        = string
  description = "ID prywatnej podsieci dla zadań Backend Fargate"
}

variable "connection_string" {
  type        = string
  description = "Łańcuch połączenia do bazy danych RDS PostgreSQL"
}

variable "frontend_image" {
  type        = string
  description = "Docker image URI dla frontend (np. 123456789.dkr.ecr.us-east-1.amazonaws.com/frontend:latest)"
}

variable "backend_image" {
  type        = string
  description = "Docker image URI dla backend (np. 123456789.dkr.ecr.us-east-1.amazonaws.com/backend:latest)"
}

variable "frontend_port" {
  type        = number
  description = "Port na którym nasłuchuje frontend"
}

variable "backend_port" {
  type        = number
  description = "Port na którym nasłuchuje backend"
}

# RDS variables dla backendu

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ARN istniejącej roli ECS Task Execution (np. arn:aws:iam::ACCOUNT_ID:role/LabRole)"
}
