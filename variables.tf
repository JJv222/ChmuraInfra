variable "aws_region"   { 
    type = string 
    default = "us-east-1"
}
variable "project_name" { 
    type = string 
    default = "my-terraform-project"
}

variable "vpc_cidr"        { type = string }
variable "public_subnets"  { type = list(string) }
variable "private_subnets" { type = list(string) }

# Fargate variables
variable "frontend_image" {
  type        = string
  description = "Docker image URI dla frontend"
}

variable "backend_image" {
  type        = string
  description = "Docker image URI dla backend"
}

variable "frontend_port" {
  type        = number
  default     = 3000
  description = "Port dla frontend"
}

variable "backend_port" {
  type        = number
  default     = 8080
  description = "Port dla backend"
}

variable "frontend_cpu" {
  type        = number
  default     = 256
  description = "CPU dla frontend"
}

variable "frontend_memory" {
  type        = number
  default     = 512
  description = "Pamięć RAM dla frontend (MB)"
}

variable "backend_cpu" {
  type        = number
  default     = 256
  description = "CPU dla backend"
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

# RDS variables
variable "db_name" {
  type        = string
  default     = "notepad"
  description = "Nazwa bazy danych"
}

variable "db_username" {
  type        = string
  default     = "postgres"
  description = "Master username dla bazy danych"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Master password dla bazy danych (min 8 znaków)"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
  description = "Rozmiar dysku w GB"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Klasa instancji RDS"
}

variable "backup_retention_days" {
  type        = number
  default     = 7
  description = "Liczba dni przechowywania backupów"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Czy włączyć Multi-AZ"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ARN istniejącej roli ECS Task Execution (np. arn:aws:iam::ACCOUNT_ID:role/LabRole)"
}