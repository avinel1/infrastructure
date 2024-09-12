resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [kubernetes_namespace.argocd_namespace]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.5.2"

  namespace = "argocd"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}

resource "null_resource" "argo_password" {
  depends_on = [helm_release.argocd]
  provisioner "local-exec" {
    command = "kubectl --kubeconfig ${var.kube-config} -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d > argocd-login.txt"
  }
}

resource "kubectl_manifest" "argo" {
  depends_on = [helm_release.argocd]
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: root
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://github.com/avinel1/infrastructure'
    targetRevision: HEAD
    path: 'apps'
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
YAML
}