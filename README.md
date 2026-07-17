# Cloud Infrastructure & GitOps CI/CD Pipeline

This repository contains the complete production-ready infrastructure and deployment pipeline definitions for the final automation project.

## Architecture & Components
- **Infrastructure Automation**: AWS Cloud environment topology mapped natively using clean Terraform modules.
- **Networking & Access Control**: Isolated Amazon VPC layout spanning segmented public/private subnets secured via custom IAM Profiles and targeted Security Groups.
- **Container Orchestration**: Production-grade Amazon EKS Cluster equipped with the AWS EBS CSI Driver add-on for dynamic volume handling.
- **Continuous Integration**: Jenkins deployment managed as code via JCasC with an isolated custom `kaniko-agent` pod template for daemonless, unprivileged container builds.
- **Continuous Delivery**: Argo CD deployment running the declarative App-of-Apps design pattern to synchronize cluster specifications with GitHub targets.
- **Persistence Layer**: Highly scalable Database deployment handling standard Amazon RDS single instances or multi-node Amazon Aurora structures seamlessly.
- **Observability System**: Enterprise-grade metrics monitoring pipeline powered by a Prometheus and Grafana stack deployment.

## Deployment Runbook

### Environment Initialization
```bash
git checkout -b final-project
terraform init
terraform apply

```

### Infrastructure Context Interception

```bash
aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks-cluster

```

### Component Verification Metrics

```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring

```

### Secure Ingress Tunneling & Port Forwarding

* **Jenkins Access**:
```bash
kubectl port-forward svc/jenkins 8080:8080 -n jenkins

```


* **Argo CD Control Plane**:
```bash
kubectl port-forward svc/argocd-server 8081:443 -n argocd

```


* **Grafana Metrics Console**:
```bash
kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n monitoring

```



## Infrastructure Teardown & Lifecycle Notice

To completely purge cloud assets and prevent unwanted cloud service provider billing fees, invoke the automated teardown pipeline:

```bash
terraform destroy

```
