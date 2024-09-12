terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
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
