variable "project_name" {
  type        = string
  description = "Nazwa projektu"
}

variable "vpc_id" {
  type        = string
  description = "ID sieci VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Lista ID prywatnych podsieci dla RDS"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Lista ID security groups dla dostępu do RDS"
}

# Database configuration
variable "db_name" {
  type        = string
  default     = "notepad"
  description = "Nazwa początkowej bazy danych"
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
  description = "Klasa instancji RDS (db.t3.micro = free tier eligible)"
}

variable "db_engine_version" {
  type        = string
  default     = "14.20"
  description = "Wersja PostgreSQL"
}

variable "backup_retention_days" {
  type        = number
  default     = 7
  description = "Liczba dni przechowywania backupów"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Czy włączyć Multi-AZ dla wysokiej dostępności"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Czy baza danych powinna być dostępna publicznie"
}
