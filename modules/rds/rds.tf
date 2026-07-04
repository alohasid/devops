resource "aws_db_instance" "main" {
  count                  = var.use_aurora ? 0 : 1
  identifier             = "${var.cluster_name}-instance"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  parameter_group_name   = aws_db_parameter_group.rds[0].name
  multi_az               = var.multi_az
  skip_final_snapshot    = true
}