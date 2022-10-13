argocd_projects = [
  "non-default"
]

argocd_applications = {
  app-of-apps = {
    application_project   = "non-default"
    repoURL               = "https://github.com/chiemerieezechukwu/argocd-app-config.git"
    targetRevision        = "HEAD"
    path                  = "apps/dev"
    destination_namespace = "app-of-apps"
  }
}
