variable "argo_cd_version" {
  type    = string
  default = "7.3.11"
}

variable "git_repo_url" {
  type        = string
  default     = "https://github.com/alohasid/devops.gitt"
  description = "URL  Git-репозиторію з інфраструктурою та чартами"
}