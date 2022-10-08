resource "helm_release" "argocd" {
  depends_on = [
    minikube_cluster.default
  ]

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.5.13"
  namespace        = "argocd"
  create_namespace = true
  force_update     = true
}

resource "helm_release" "root_app" {
  depends_on = [
    helm_release.argocd
  ]

  name             = "root-app"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  version          = "0.0.1"
  namespace        = "argocd"
  create_namespace = true
  force_update     = true

  values = [file("helm/root_app_config/values.yaml")]
}
