output "get_admin_password_command" {
  description = "Command to retrieve the Jenkins auto-generated admin password"
  value       = "kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo"
}

output "get_url_command" {
  description = "Command to retrieve the Jenkins LoadBalancer URL"
  value       = "kubectl get svc --namespace jenkins jenkins -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

