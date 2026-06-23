# AWS Infrastructure via Terraform (Lesson 5)

This repository contains reusable Terraform modules to deploy an architecture on AWS, incorporating isolated networks, container registries, and shared state tracking.

## Project Structure
- modules/s3-backend: Creates an S3 bucket with encryption/versioning enabled and a DynamoDB component for distributed locks.
- modules/vpc: Establishes a virtual environment with 3 public subnets and 3 private subnets.
- modules/ecr: Generates an Elastic Container Registry repo with automated security scanning profiles.

## Orchestration Commands

### Step 1: Initial Deployment
Comment out the backend s3 block inside backend.tf first if the destination targets do not exist yet, then issue:
terraform init
terraform apply

### Step 2: Migrate State Tracking
Uncomment the backend s3 definition blocks inside backend.tf to switch targets dynamically:
```
terraform init -migrate-state
```

### Regular Life Cycle
```
terraform plan
terraform apply
terraform destroy
```