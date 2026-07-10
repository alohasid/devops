output "ecr_repository_url" {
  description = "The URL of the created ECR repository"
  value       = aws_ecr_repository.repo.repository_url
}

output "repository_url" {
  value = aws_ecr_repository.repo.repository_url
}