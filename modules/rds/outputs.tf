output "endpoint" {
  value = var.use_aurora ? aws_rds_cluster.main[0].endpoint : aws_db_instance.main[0].endpoint
}

output "security_group_id" {
  value = aws_security_group.db.id
}