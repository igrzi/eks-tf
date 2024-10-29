provider "aws" {
  profile = var.profile
  region  = var.region
}

# Tag locals
locals {
  created_at_tag = contains(keys(var.tags), "Created-at") ? var.tags["Created-at"] : formatdate("DD MMM YY hh:mm:ss", timestamp())
}

module "eks_pod_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "eks_pod_sg"
  description = "Security group for EKS pods"
  vpc_id      = var.vpc

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP traffic"
      cidr_blocks = "172.31.0.0/16"
    },
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "172.31.0.0/16"
    }
  ]

  tags = merge(
    var.tags,
    {
      Created-at = local.created_at_tag,
    }
  )
}