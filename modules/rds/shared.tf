resource "aws_db_subnet_group" "main" {
  name       = "${var.cluster_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.cluster_name}-subnet-group"
  }
}

resource "aws_security_group" "db" {
  name        = "${var.cluster_name}-db-sg"
  description = "Security group for database access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.engine == "postgres" || var.engine == "aurora-postgresql" ? 5432 : 3306
    to_port     = var.engine == "postgres" || var.engine == "aurora-postgresql" ? 5432 : 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-db-sg"
  }
}

resource "aws_db_parameter_group" "rds" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.cluster_name}-rds-pg"
  family = var.engine == "postgres" ? "postgres15" : "mysql8.0"

  parameter {
    name  = "max_connections"
    value = "100"
  }

  parameter {
    name  = var.engine == "postgres" ? "log_statement" : "general_log"
    value = var.engine == "postgres" ? "all" : "1"
  }
}

resource "aws_rds_cluster_parameter_group" "aurora" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.cluster_name}-aurora-pg"
  family = var.engine == "aurora-postgresql" ? "aurora-postgresql15" : "aurora-mysql8.0"

  parameter {
    name  = "max_connections"
    value = "200"
  }

  parameter {
    name  = var.engine == "aurora-postgresql" ? "log_statement" : "general_log"
    value = var.engine == "aurora-postgresql" ? "all" : "1"
  }
}