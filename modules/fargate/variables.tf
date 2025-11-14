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

variable "private_subnet_ids" {
  type        = list(string)
  description = "Lista ID prywatnych podsieci dla ECS tasks"
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
  default     = 3000
  description = "Port na którym nasłuchuje frontend"
}

variable "backend_port" {
  type        = number
  default     = 8080
  description = "Port na którym nasłuchuje backend"
}

variable "frontend_cpu" {
  type        = number
  default     = 256
  description = "CPU dla frontend (256, 512, 1024, etc.)"
}

variable "frontend_memory" {
  type        = number
  default     = 512
  description = "Pamięć RAM dla frontend (MB)"
}

variable "backend_cpu" {
  type        = number
  default     = 256
  description = "CPU dla backend (256, 512, 1024, etc.)"
}

variable "backend_memory" {
  type        = number
  default     = 512
  description = "Pamięć RAM dla backend (MB)"
}

variable "frontend_replicas" {
  type        = number
  default     = 2
  description = "Liczba replik frontend"
}

variable "backend_replicas" {
  type        = number
  default     = 2
  description = "Liczba replik backend"
}

# RDS variables dla backendu
variable "db_host" {
  type        = string
  description = "RDS Database host"
}

variable "db_port" {
  type        = number
  default     = 5432
  description = "RDS Database port"
}

variable "db_name" {
  type        = string
  description = "RDS Database name"
}

variable "db_username" {
  type        = string
  description = "RDS Database username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS Database password"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ARN istniejącej roli ECS Task Execution (np. arn:aws:iam::ACCOUNT_ID:role/LabRole)"
}
