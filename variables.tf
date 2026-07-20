variable "db_password" {
  type      = string
  sensitive = true
  default   = "MySecurePassword123!"
}

variable "git_repo_url" {
  type    = string
  default = "https://github.com/alohasid/devops.git"
}

variable "django_secret_key" {
  type      = string
  sensitive = true
  default   = "super-secret-django-key-2026"
}