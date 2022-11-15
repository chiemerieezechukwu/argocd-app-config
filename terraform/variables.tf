variable "argocd_apps_version" {
  description = "ArgoCD apps chart version"
  type        = string
  default     = "0.0.1"
}

variable "argocd_projects" {
  description = "ArgoCD projects"
  type        = list(string)
  default     = ["non-default"]
}

variable "argocd_applications" {
  description = "ArgoCD applications"
  type = map(object({
    application_project   = string
    repoURL               = string
    targetRevision        = string
    path                  = string
    destination_namespace = string
  }))
}

variable "cluster_datastore_name" {
  description = "Name of the cluster datastore"
  type        = string
  default     = "cluster-datastore"
}

variable "env" {
  default = "dev"
}

variable "cluster_name" {
  default = "applicationset-cluster"
}
