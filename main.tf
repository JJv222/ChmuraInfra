module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Security Group dla komunikacji między Fargate a RDS
resource "aws_security_group" "rds_access" {
  name        = "${var.project_name}-rds-access-sg"
  description = "Allows Fargate ECS tasks to access RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.10.0/23"]  # Private subnets CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-access-sg"
  }
}

module "fargate" {
  source               = "./modules/fargate"
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  private_subnet_ids   = module.vpc.private_subnet_ids
  frontend_image       = var.frontend_image
  backend_image        = var.backend_image
  frontend_port        = var.frontend_port
  backend_port         = var.backend_port
  frontend_cpu         = var.frontend_cpu
  frontend_memory      = var.frontend_memory
  backend_cpu          = var.backend_cpu
  backend_memory       = var.backend_memory
  frontend_replicas    = var.frontend_replicas
  backend_replicas     = var.backend_replicas
  
  # RDS connection
  db_host              = module.rds.db_host
  db_port              = module.rds.db_port
  db_name              = module.rds.db_name
  db_username          = module.rds.db_username
  db_password          = var.db_password
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  security_group_ids  = [aws_security_group.rds_access.id]
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  db_allocated_storage = var.db_allocated_storage
  db_instance_class   = var.db_instance_class
  backup_retention_days = var.backup_retention_days
  multi_az            = var.multi_az
}