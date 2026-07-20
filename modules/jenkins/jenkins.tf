resource "kubernetes_namespace_v1" "jenkins" {
  metadata {
    name = var.jenkins_namespace
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = kubernetes_namespace_v1.jenkins.metadata[0].name

  values = [
    file("${path.module}/values.yaml")
  ]
}