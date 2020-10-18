provider "helm" {
  version = "~> 1.3.2"
  kubernetes {
    config_path = "/path/to/kube_cluster.yaml"
  }
}
