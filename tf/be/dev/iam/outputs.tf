output "iam_role" {
  value = aws_iam_role.iam-role
}

output "eks_cluster_policy" {
  value   = aws_iam_role_policy_attachment.eks-cluster-policy.id
}

output "eks_vpc_resource_controller" {
  value   = aws_iam_role_policy_attachment.eks-vpc-resource-controller.id
}

output "node_role" {
  value = aws_iam_role.node-role
}

output "eks_node_policy" {
  value = aws_iam_role_policy_attachment.eks-node-policy
}

output "eks_node_cni_policy" {
  value = aws_iam_role_policy_attachment.eks-node-cni-policy
}