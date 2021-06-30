resource "aws_eks_node_group" "node-group-biz" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.eks_node_group.name
  node_role_arn   = var.node_role.arn
  subnet_ids      = concat(var.subnet_pri_cz_ids, var.subnet_pri_az_ids)


  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  disk_size = 20
  instance_types = [ var.eks_node_group.type ]

  labels = {
    service = var.eks_node_group.name
  }

  remote_access {
    ec2_ssh_key = var.eks_node_group.key
    source_security_group_ids = [ aws_security_group.sg-eks-node.id ]
  }

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.eks_node_policy,
    var.eks_node_cni_policy
  ]

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.eks_node_group.name}"), var.extra_tags)


}