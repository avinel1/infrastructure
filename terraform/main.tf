terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}

provider "linode" {
}

provider "helm" {
  kubernetes {
    config_path = "kube-config"
  }
}

resource "linode_lke_cluster" "lke_cluster" {
  label       = "main"
  k8s_version = "1.30"
  region      = "eu-central"

  pool {
    type  = "g6-standard-2"
    count = 3
  }
}

resource "helm_release" "argocd" {
  depends_on = [local_file.kubeconfig]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.5.2"

  namespace = "argocd"

  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}