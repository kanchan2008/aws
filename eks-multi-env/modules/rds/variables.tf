variable "name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "eks_node_sg" {}