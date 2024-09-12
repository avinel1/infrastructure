terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.27.0"
    }
  }
}

provider "linode" {
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