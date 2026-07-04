variable "cluster_name" {
  type        = string
  description = "Name prefix for RDS resources"
  default     = "lesson-db"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where DB will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for DB subnet group"
}

variable "use_aurora" {
  type        = bool
  description = "If true, Aurora cluster will be created. If false, standard RDS instance will be created"
  default     = false
}

variable "engine" {
  type        = string
  description = "Database engine type (postgres, mysql, aurora-postgresql, aurora-mysql)"
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Database engine version"
  default     = "15.4"
}

variable "instance_class" {
  type        = string
  description = "Instance type for database"
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage size in GB (ignored for Aurora)"
  default     = 20
}

variable "db_name" {
  type        = string
  description = "The name of the database to create"
  default     = "devops_db"
}

variable "username" {
  type        = string
  description = "Username for the master DB user"
  default     = "devops_user"
}

variable "password" {
  type        = string
  description = "Password for the master DB user"
  sensitive   = true
}

variable "multi_az" {
  type        = bool
  description = "Specifies if the RDS instance or Aurora cluster is multi-AZ"
  default     = false
}