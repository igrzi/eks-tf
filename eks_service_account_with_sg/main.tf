terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.33.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

module "iam_eks_role" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-eks-role"

  role_name   = "${var.client_name}-eks-role"
  tags        = var.tags
  role_policy_arns = var.role_policy_arns

  cluster_service_accounts = {
    "tf-eks" = ["${var.namespace}:${var.client_name}"]
  }
}

resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.client_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_eks_role.iam_role_arn
    }
    labels = {
      "${var.namespace}" = "${var.client_name}"
    }
  }
}

resource "kubernetes_manifest" "security_group_policy" {
  manifest = {
    "apiVersion" = "vpcresources.k8s.aws/v1beta1"
    "kind"       = "SecurityGroupPolicy"
    "metadata" = {
      "name" = "${var.client_name}-sg-policy"
      "namespace" = "${var.namespace}"
    }
    "spec" = {
      "serviceAccountSelector" = {
        "matchLabels" = {
          "${var.namespace}" = "${var.client_name}"
        }
      }
      "securityGroups" = {
        "groupIds" = "${var.security_group_ids}"
      }
    }
  }
}