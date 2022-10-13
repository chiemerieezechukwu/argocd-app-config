terraform {
  required_version = "~> 1.0"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "~> 0.0.3"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.23.3"
}

provider "helm" {
  kubernetes {
    host                   = minikube_cluster.default.host
    cluster_ca_certificate = minikube_cluster.default.cluster_ca_certificate
    client_certificate     = minikube_cluster.default.client_certificate
    client_key             = minikube_cluster.default.client_key
  }
}

provider "kubernetes" {
  host                   = minikube_cluster.default.host
  cluster_ca_certificate = minikube_cluster.default.cluster_ca_certificate
  client_certificate     = minikube_cluster.default.client_certificate
  client_key             = minikube_cluster.default.client_key
}
