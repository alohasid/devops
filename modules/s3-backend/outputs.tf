output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = aws_s3_bucket.state_bucket.arn
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for state locking"
  value       = aws_dynamodb_table.locks.name
}