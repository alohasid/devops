data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "sydorenko-oleksii-terraform-bucket"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "lesson-7-vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-5-ecr"
  scan_on_push = true
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "lesson-7-eks-cluster"
  subnet_ids   = module.vpc.private_subnet_ids
}

module "jenkins" {
  source         = "./modules/jenkins"
  cluster_name   = module.eks.cluster_name
  ecr_repository = module.ecr.repository_url
  git_repo_url   = var.git_repo_url
  depends_on     = [module.eks]
}
module "argo_cd" {
  source            = "./modules/argo_cd"
  git_repo_url      = var.git_repo_url
  postgres_host     = module.rds.endpoint
  db_password       = var.db_password
  django_secret_key = var.django_secret_key
  depends_on        = [module.eks]
}

module "rds" {
  source            = "./modules/rds"
  cluster_name      = "lesson-db-module"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  use_aurora        = false
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.medium"
  allocated_storage = 20
  db_name           = "devops_db"
  username          = "devops_user"
  password          = var.db_password
  db_password       = var.db_password
  multi_az          = false
}