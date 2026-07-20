terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "arn:aws:eks:${var.aws_region}:054129814654:cluster/goit-devops-final-eks"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "arn:aws:eks:${var.aws_region}:054129814654:cluster/goit-devops-final-eks"
  }
}