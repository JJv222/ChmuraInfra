module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_availability_zones = var.availability_zones
  backend_availability_zone = public_availability_zones[0]
  public_subnets =   var.public_subnets
  private_subnet  = var.private_subnet
}

module "alb" {
  source = "./modules/alb"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  frontend_port = var.frontend_port
  backend_port = var.backend_port
  alb_subnets = module.vpc.public_subnets
  security_groups = [aws_security_group.frontend_alb.id, aws_security_group.backend_alb.id]
}


module "ecr" {
  source = "./modules/ecr"
  project_name = var.project_name
}

module "s3" {
  source = "./modules/s3"
  project_name = var.project_name
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_id  = module.private_subnet
  security_group_id  =  aws_security_group.rds_access.id
  db_username         = var.db_username
  db_password         = var.db_password
  db_port             =  var.db_port
}


module "fargate" {
  source = "./modules/fargate"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  private_subnet_id = module.vpc.private_subnet
  s3_name = module.s3.bucket_name
  connection_string = module.rds.connection_string
  frontend_image = module.ecr.fronted_repository_url
  backend_image = module.ecr.backend_repository_url
  frontend_port = var.frontend_port
  backend_port = var.backend_port
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
}



# Security Groups for Fargate and RDS

# =======================
# PUBLIC FRONTEND ALB SG
# =======================
resource "aws_security_group" "frontend_alb" {
  name        = "frontend_alb_sg"
  description = "Public ALB for frontend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Internet -> Frontend ALB "
    from_port   = var.frontend_port
    to_port     = var.frontend_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description     = "Frontend ALB -> Frontend Fargate"
    from_port       = var.frontend_port
    to_port         = var.frontend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_fargate.id]
  }
}

# =====================
# FRONTEND FARGATE SG
# =====================
resource "aws_security_group" "frontend_fargate" {
  name        = "frontend_fargate_sg"
  description = "Frontend tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Frontend ALB -> Frontend tasks"
    from_port       = var.frontend_port
    to_port         = var.frontend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_alb.id]
  }

  egress {
    description = "Frontend -> Internet (or Backend ALB)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ======================
# INTERNAL BACKEND ALB SG
# ======================
resource "aws_security_group" "backend_alb" {
  name        = "backend_alb_sg"
  description = "Internal ALB for backend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Frontend tasks -> Backend ALB"
    from_port       = var.backend_port
    to_port         = var.backend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_fargate.id]
  }

  egress {
    description     = "Backend ALB -> Backend tasks"
    from_port       = var.backend_port
    to_port         = var.backend_port 
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_fargate.id]
  }
}

# ====================
# BACKEND FARGATE SG
# ====================
resource "aws_security_group" "backend_fargate" {
  name        = "backend_fargate_sg"
  description = "Backend tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Backend ALB -> Backend tasks"
    from_port       = var.backend_port
    to_port         = var.backend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_alb.id]
  }

  egress {
    description     = "Backend tasks -> RDS"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.rds_access.id]
  }

  egress {
    description = "Backend -> Internet (ECR, external APIs)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# =============
# RDS ACCESS SG
# =============
resource "aws_security_group" "rds_access" {
  name        = "${var.project_name}-rds-access-sg"
  description = "Allows Backend tasks to access RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Backend tasks -> RDS (5432)"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_fargate.id]
  }

  egress {
    description = "RDS outbound (default allow-all)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
