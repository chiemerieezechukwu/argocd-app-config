resource "random_pet" "this" {
  count     = 5
  length    = 2
  separator = "-"
}

resource "kubernetes_manifest" "argocd_cluster_datastore" {
  depends_on = [
    kind_cluster.default
  ]

  manifest = {
    apiVersion = "v1"
    kind       = "Secret"
    type       = "Opaque"
    metadata = {
      name      = var.cluster_datastore_name
      namespace = "argocd"
      labels = {
        "argocd.argoproj.io/secret-type" = "cluster"
        "app.kubernetes.io/managed-by" : "terraform"
        "purpose" : var.cluster_datastore_name
      }
      annotations = {
        test-annotation = "test-annotation"
        test-message    = "Testing test message"
        custom-value-1  = random_pet.this[0].id
        custom-value-2  = random_pet.this[1].id
        custom-value-3  = random_pet.this[2].id
        custom-value-4  = random_pet.this[3].id
        custom-value-5  = random_pet.this[4].id
        list-all-pets  = jsonencode([for i in range(0, 5) : random_pet.this[i].id])
      }
    }
    data = {
      name   = base64encode(var.cluster_datastore_name)
      server = base64encode("dummy")
    }
  }
}