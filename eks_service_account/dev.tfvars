profile = "igor"
region  = "us-east-1"
client_name = "cliente-001"
tags = {
  Environment = "testing"
  Terraform   = "true"
}
role_policy_arns = {
  AmazonEC2ReadOnlyAccess = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
cluster_name = "tf-eks"
namespace = "small-clients"