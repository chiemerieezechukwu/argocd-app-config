terraform {
  required_version = "~> 1.0"

  backend "s3" {
    bucket  = "terraform-state-bucket-20220507150748321300000001"
    key     = "minikube-argocd/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }

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
