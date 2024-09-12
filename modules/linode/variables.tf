variable "cluster_label" {
  description = "Label for the LKE cluster"
  type        = string
  default     = "main"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "region" {
  description = "Linode region"
  type        = string
  default     = "eu-central"
}

variable "node_type" {
  description = "Linode node type"
  type        = string
  default     = "g6-standard-2"
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
  default     = 1
}

variable "kube-config" {
  description = "Name of kube config file"
  type = string
  default = "kubeconfig.yaml"
}