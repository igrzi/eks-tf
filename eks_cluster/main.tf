provider "aws" {
  profile = var.profile
  region  = var.region
} 

# Tag locals
locals {
  created_at_tag = contains(keys(var.tags), "Created-at") ? var.tags["Created-at"] : formatdate("DD MMM YY hh:mm:ss", timestamp())
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = var.vpc
  subnet_ids               = var.node_subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids
  
  iam_role_additional_policies = {
    "additional-policies-alb" = "arn:aws:iam::381492167245:policy/additional-policies-alb"
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.instance_types
  }

  eks_managed_node_groups = {
    tf-eks-node-group = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = var.instance_types
      

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
  enable_cluster_creator_admin_permissions = true

  # Cluster access entry
  access_entries = {
    tf-eks-node = {
      principal_arn     = var.node_role_arn

      # Optional
      /*
      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
      */
    }
  }

  tags = merge(
    var.tags,
    {
      Created-at = local.created_at_tag,
    }
  )
}