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

output "jenkins_admin_password_command" {
  value = module.jenkins.get_admin_password_command
}

output "jenkins_url_command" {
  value = module.jenkins.get_url_command
}

output "database_endpoint" {
  value = module.rds.endpoint
}

output "grafana_port_forward_command" {
  value = "kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n monitoring"
}