variable "jenkins_namespace" {
  type        = string
  default     = "jenkins"
  description = "Kubernetes namespace for Jenkins"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "ecr_repository" {
  type        = string
  default     = ""
  description = "ECR Repository URL"
}

variable "git_repo_url" {
  type        = string
  default     = "https://github.com/alohasid/devops.git"
  description = "Git Repository URL"
}