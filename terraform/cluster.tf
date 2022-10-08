resource "minikube_cluster" "default" {
  driver       = "docker"
  cluster_name = "minikube-cluster"
}