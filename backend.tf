terraform {
  backend "s3" {
    bucket         = "final-devops-tfstate-054129814654"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "final-devops-tf-lock"
    encrypt        = true
  }
}