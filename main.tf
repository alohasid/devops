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
  kubernetes {
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
  source = "./modules/vpc"
}

module "ecr" {
  source = "./modules/ecr"
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "lesson-7-eks-cluster"
  subnet_ids   = module.vpc.private_subnet_ids
}

module "jenkins" {
  source       = "./modules/jenkins"
  cluster_name = module.eks.cluster_name
  depends_on   = [module.eks]
}

module "argo_cd" {
  source       = "./modules/argo_cd"
  git_repo_url = "https://github.com/alohasid/devops.git"
  depends_on   = [module.eks]
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
  db_password       = var.db_password
  multi_az          = false
}