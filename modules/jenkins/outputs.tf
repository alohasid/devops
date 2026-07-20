output "jenkins_namespace" {
  value = kubernetes_namespace_v1.jenkins.metadata[0].name
}

output "get_admin_password_command" {
  value = "kubectl get secret --namespace jenkins jenkins -o jsonpath=\"{.data.jenkins-admin-password}\" | base64 --decode"
}

output "get_url_command" {
  value = "kubectl port-forward svc/jenkins 8080:8080 -n jenkins"
}