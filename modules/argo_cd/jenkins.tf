resource "helm_release" "argo_cd_apps" {
  name       = "argo-cd-apps"
  chart      = "${path.module}/charts"
  namespace  = "argocd"
  depends_on = [helm_release.argo_cd]

  set {
    name  = "repoUrl"
    value = var.git_repo_url
  }

  set {
    name  = "configMap.POSTGRES_HOST"
    value = var.postgres_host
  }

  set {
    name  = "secret.postgresPassword"
    value = var.db_password
  }

  set {
    name  = "secret.secretKey"
    value = var.django_secret_key
  }
}

resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argo_cd_version
  namespace        = var.argo_cd_namespace
  create_namespace = true
  values           = [file("${path.module}/values.yaml")]
}