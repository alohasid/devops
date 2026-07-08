output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "jenkins_url" {
  value = "Check Kubernetes Services for Jenkins LoadBalancer External IP"
}

output "argocd_url" {
  value = "Check Kubernetes Services for ArgoCD Server LoadBalancer External IP"
}

output "database_endpoint" {
  value       = module.rds.endpoint
  description = "The connection endpoint for the created RDS instance or Aurora Cluster"
}