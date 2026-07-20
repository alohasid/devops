variable "git_repo_url" {
  type    = string
  default = "https://github.com/alohasid/devops.git"
}

variable "postgres_host" {
  type    = string
  default = ""
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "django_secret_key" {
  type      = string
  sensitive = true
  default   = ""
}