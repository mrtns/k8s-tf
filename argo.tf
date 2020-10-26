resource "helm_release" "argo" {
  name       = "aaargo"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo"
}
