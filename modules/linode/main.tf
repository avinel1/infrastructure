resource "linode_lke_cluster" "lke_cluster" {
  label       = var.cluster_label
  k8s_version = var.k8s_version
  region      = var.region

  pool {
    type  = var.node_type
    count = var.node_count
  }
}

resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.lke_cluster]
  filename   = var.kube-config
  content    = base64decode(linode_lke_cluster.lke_cluster.kubeconfig)
}