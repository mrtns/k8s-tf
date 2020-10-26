provider "helm" {
  version = "~> 1.3.2"
  kubernetes {
    load_config_file = "false"
    host             = "https://${var.kubernetes_host}"

    client_certificate     = file(var.kubernetes_client_certificate_path)
    client_key             = file(var.kubernetes_client_key_path)
    cluster_ca_certificate = file(var.kubernetes_cluster_ca_certificate_path)
  }
}
