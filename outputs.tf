output "s3_bucket_arn" {
  description = "The ARN of the S3 state bucket from s3_backend module"
  value       = module.s3_backend.s3_bucket_arn
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB lock table from s3_backend module"
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
  description = "The ID of the VPC from vpc module"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of public subnets from vpc module"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of private subnets from vpc module"
  value       = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository from ecr module"
  value       = module.ecr.ecr_repository_url
}