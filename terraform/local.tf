locals {
  path_to_clusters = "${path.module}/../apps"

  cluster_config = yamldecode(file("${local.path_to_clusters}/${var.env}/${var.cluster_name}.yaml"))["metadata"]
  t = {
    argocd_applications = var.argocd_applications
  }
}

output "namer" {
  value = merge(local.t, {})
}