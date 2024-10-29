variable "profile" {
  type = string
  description = "AWS profile name"
}

variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type = string
  description = "EKS cluster version"
  default = "1.31"
}

variable "vpc" {
  type = string
  description = "VPC ID"
}

variable "node_subnet_ids" {
  type = list(string)
  description = "Subnet IDs for created EC2 instances"
}

variable "control_plane_subnet_ids" {
  type = list(string)
  description = "Control plane subnet IDs"
}

variable "instance_types" {
  type = list(string)
  description = "Instance types"
}

variable "node_role_arn" {
  type = string
  description = "Node role ARN"
}

variable "tags" {
  type = map(string)
  description = "Tags"
}