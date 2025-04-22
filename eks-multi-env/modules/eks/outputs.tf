output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_node_sg_id" {
  value = aws_security_group.eks_node_sg.id
}