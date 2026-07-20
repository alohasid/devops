

# Final Project

## System Architecture

- **Networking:** dedicated AWS VPC with both public and private subnets distributed across two Availability Zones  
- **Compute Layer:** Amazon EKS cluster with a managed node group for running Kubernetes workloads  
- **Container Registry:** Amazon ECR used to store application container images  
- **Database Layer:** Amazon RDS MySQL instance for Django data persistence  
- **Continuous Integration:** Jenkins installed in Kubernetes using Helm  
- **Continuous Deployment / GitOps:** Argo CD deployed via Helm and configured to monitor the application Helm chart  
- **Observability:** kube-prometheus-stack including Prometheus and Grafana  
- **Application Layer:** example Django application deployed through a Helm chart  

## Project Layout

- `bootstrap/backend/` — Terraform configuration used to initialize the remote state backend (S3 + DynamoDB)  
- `modules/` — collection of reusable Terraform modules for AWS and Kubernetes infrastructure  
- `charts/django-app/` — Helm chart responsible for deploying the sample application  
- `Django/` — Django application source code, including Dockerfile, dependencies, and Jenkins pipeline  
- `backend.hcl.example` — sample configuration file for Terraform remote state  
- `terraform.tfvars.example` — example variables file for the project  

## Deployment Steps

### 1. Initialize Terraform backend

```bash
cd bootstrap/backend
terraform init
terraform apply
```

After running this step, use the generated outputs to create a `backend.hcl` file based on `backend.hcl.example`.

### 2. Create configuration files from examples

```bash
cp backend.hcl.example backend.hcl
cp terraform.tfvars.example terraform.tfvars
```

Adjust the values in these files according to your AWS account, selected Git branch, and target environment before proceeding.

### 3. Deploy the main infrastructure

```bash
terraform init -backend-config=backend.hcl -reconfigure
terraform plan
terraform apply
```

### 4. Set up local Kubernetes access

```bash
aws eks update-kubeconfig --region eu-central-1 --name $(terraform output -raw eks_cluster_name)
```

### 5. Check deployed namespaces

```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring
```

### 6. Access services using port forwarding

```bash
kubectl port-forward svc/jenkins 8080:8080 -n jenkins
kubectl port-forward svc/argocd-server 8081:443 -n argocd
kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n monitoring
```

## CI/CD Workflow

1. Changes are committed and pushed to the Git repository.  
2. Jenkins pulls the repository and builds a Docker image for the Django application.  
3. The image is tagged and pushed to Amazon ECR.  
4. Jenkins updates the image tag inside `charts/django-app/values.yaml`.  
5. Argo CD detects the update in the repository and synchronizes the application state with the EKS cluster.  
6. Prometheus collects metrics from the `/metrics` endpoint, and Grafana provides visualization.  

## Resource Cleanup

```bash
terraform destroy
```