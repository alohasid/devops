# GitOps CI/CD Pipeline Infrastructure (Jenkins + Argo CD + Helm)

This deployment architecture configures a complete, automated continuous integration and continuous delivery loop leveraging Jenkins for image artifact generation and Argo CD for declaration tracking.

## Pipeline Topologies
- **Infrastructure Provisioning**: Orchestrated entirely via modularized Terraform bundles including full Kubernetes and Helm providers.
- **Continuous Integration**: Triggered inside EKS isolated node steps using ephemeral Kaniko executors to eliminate Root socket exposure.
- **Continuous Deployment**: Maintained synchronously via the Argo CD Application engine utilizing the App-of-Apps automation model.

## Orchestration Runbook

### Infrastructure Instantiation
Initialize backend declarations and execute operational state blueprints:
```bash
terraform init
terraform apply

```

### Administrative Context Acquisition

Update local configuration targets to establish secure communication hooks with the infrastructure control plane:

```bash
aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks-cluster

```

### Core Automation Pipelines

The underlying Jenkinsfile engine manages container lifecycles safely:

1. **Verification**: Builds layers via non-privileged context mapping.
2. **Registry Distribution**: Delivers distinct immutable tags natively to Amazon ECR.
3. **State Mutation**: Performs precise space-retaining token overrides inside `charts/django-app/values.yaml` using regex mapping components.
4. **Synchronization**: Propagates atomic mutation updates back to GitHub securely.

### Operational Observation

Inspect active processing engines and application state topologies directly:

```bash
kubectl get pods -n jenkins
kubectl get svc -n argocd

```