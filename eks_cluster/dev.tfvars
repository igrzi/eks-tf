profile = "igor"
region  = "us-east-1"
cluster_name = "tf-eks"
vpc = "vpc-03ae3f1b9f7028861"
node_subnet_ids = ["subnet-0a76565b7dbe225c0"]
control_plane_subnet_ids = ["subnet-0a76565b7dbe225c0", "subnet-0f7b62b63dbbe84b0", "subnet-00a7639317b42f007"]
instance_types = ["m5.large"]
tags = {
  Environment = "testing"
  Terraform   = "true"
}
node_role_arn = "arn:aws:iam::381492167245:role/eks-node-manual"