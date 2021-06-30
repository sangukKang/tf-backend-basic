output "eks_cluster" {
  value   = aws_eks_cluster.eks-cluster.id
}

output "eks_name" {
  value = aws_eks_cluster.eks-cluster.name
}

output "eks_ng_biz" {
  value = aws_eks_node_group.node-group-biz.id
}
