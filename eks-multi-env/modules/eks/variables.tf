variable "name" {}
variable "subnet_ids" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "vpc_id" {}
variable "region" {}
variable "cluster_role_arn" {}