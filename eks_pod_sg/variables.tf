variable "profile" {
  type = string
  description = "AWS profile name"
}

variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-1"
}

variable "vpc" {
  type = string
  description = "VPC ID"
}

variable "tags" {
  type = map(string)
  description = "Tags"
}