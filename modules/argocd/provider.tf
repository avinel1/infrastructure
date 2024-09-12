provider "helm" {
  kubernetes {
    config_path = var.kube-config
  }
}

provider "kubernetes" {
  config_path = var.kube-config
}

provider "kubectl" {
  config_path = var.kube-config
}