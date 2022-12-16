provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_namespace" "my-ns" {
  metadata {
    name = "kiratech-test"
  }
}
