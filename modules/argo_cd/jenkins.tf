resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argo_cd_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  values = [
    file("${path.module}/values.yaml")
  ]
}

resource "helm_release" "argocd_apps" {
  name      = "argocd-apps"
  chart     = "${path.module}/charts"
  namespace = kubernetes_namespace.argocd.metadata[0].name

  set {
    name  = "repoUrl"
    value = var.git_repo_url
  }

  depends_on = [helm_release.argocd]
}