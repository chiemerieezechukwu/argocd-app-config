resource "helm_release" "argocd" {
  depends_on = [
    minikube_cluster.default
  ]

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.13.8"
  namespace        = "argocd"
  create_namespace = true
  force_update     = true

  set {
    name  = "global.image.tag"
    value = "v2.8.4"
  }
}

resource "helm_release" "argocd_project" {
  description = "ArgoCD projects"

  depends_on = [
    helm_release.argocd
  ]

  name         = "projects"
  repository   = "https://argoproj.github.io/argo-helm"
  chart        = "argocd-apps"
  version      = var.argocd_apps_version
  namespace    = "argocd"
  force_update = true

  values = [
    yamlencode({
      projects = [
        for project in var.argocd_projects : {
          name = project
          sourceRepos = [
            "*"
          ]
          destinations = [
            {
              namespace = "*"
              server    = "*"
            }
          ]
          clusterResourceWhitelist = [
            {
              group = "*"
              kind  = "*"
            }
          ]
        }
      ]
    })
  ]
}

resource "helm_release" "application" {
  description = "Initial app of app"

  depends_on = [
    helm_release.argocd
  ]

  name         = "applications"
  repository   = "https://argoproj.github.io/argo-helm"
  chart        = "argocd-apps"
  version      = var.argocd_apps_version
  namespace    = "argocd"
  force_update = true

  values = [
    yamlencode({
      # field values reference -> https://github.com/argoproj/argo-helm/blob/main/charts/argocd-apps/values.yaml
      applications = [
        for key, value in var.argocd_applications : {
          name    = key
          project = value.application_project
          additionalLabels = {
            "app.kubernetes.io/managed-by" = "terraform"
          }
          source = {
            repoURL        = value.repoURL
            targetRevision = value.targetRevision
            path           = value.path
          }
          destination = {
            namespace = value.destination_namespace
            server    = "https://kubernetes.default.svc"
          }
          syncPolicy = {
            automated = {
              prune    = true
              selfHeal = true
            }
            syncOptions = [
              "CreateNamespace=true"
            ]
          }
        }
      ]
    })
  ]
}
