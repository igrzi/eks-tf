variable "profile" {
  type = string
  description = "AWS profile name"
}

variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-1"
}

variable "client_name" {
  type = string
  description = "Client name"
}

variable "tags" {
  type = map(string)
  description = "Tags"
}

variable "role_policy_arns" {
  type = map(string)
  description = "Role policy ARNs"
}

variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}

variable "namespace" {
  type = string
  description = "Kubernetes namespace"
}

variable "security_group_ids" {
  type = list(string)
  description = "Security group IDs"
}