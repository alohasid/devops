resource "aws_rds_cluster" "main" {
  count                           = var.use_aurora ? 1 : 0
  cluster_identifier              = "${var.cluster_name}-aurora-cluster"
  engine                          = var.engine
  engine_version                  = var.engine_version
  database_name                   = var.db_name
  master_username                 = var.username
  master_password                 = var.password
  db_subnet_group_name            = aws_db_subnet_group.main.name
  vpc_security_group_ids          = [aws_security_group.db.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora[0].name
  skip_final_snapshot             = true
}

resource "aws_rds_cluster_instance" "main" {
  count              = var.use_aurora ? (var.multi_az ? 2 : 1) : 0
  identifier         = "${var.cluster_name}-aurora-node-${count.index}"
  cluster_identifier = aws_rds_cluster.main[0].id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.main[0].engine
  engine_version     = aws_rds_cluster.main[0].engine_version
}