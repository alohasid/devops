# AWS EKS Infrastructure & Django Deployment via Helm (Lesson 7)

This repository contains reusable Terraform modules to deploy an Amazon EKS cluster within an isolated network and package a Django application using Helm charts with autoscale configurations.

## Project Structure
- modules/s3-backend: Configures an encrypted S3 bucket and active use_lockfile parameters for remote states.
- modules/vpc: Establishes a virtual networking infrastructure containing public and private subnets.
- modules/ecr: Provisions a secure container registry with automated lifecycle management profiles.
- modules/eks: Launches an elastic Kubernetes cluster bound to active private node configurations.
- charts/django-app: Encapsulates deployment templates, dynamic horizontal auto-scalers, and liveness configurations.

## Orchestration Lifecycle

### Step 1: Network & Platform Bootstrapping
Comment out the backend definition blocks inside backend.tf to initiate local tracking state resources, then run:
terraform init
terraform apply

### Step 2: Establish Remote State Synchronization
Uncomment the active backend s3 settings within backend.tf to target the newly instantiated object buckets:
terraform init -migrate-state

### Step 3: Kubernetes Operations
Acquire standard administrative cluster execution profiles locally:
aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks-cluster

### Step 4: Component Application Deployment
Package and install application templates to operational runtimes using Helm commands:
helm install django-release ./charts/django-app