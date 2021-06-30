resource "aws_eks_cluster" "eks_cluster" {
  name      = "${var.resrc_prefix_nm}-${var.eks_cluster.name}"
  role_arn  = var.iam_eks_arn

  vpc_config {
    subnet_ids  = [ var.sn_pub_a_id, var.sn_pub_c_id, var.sn_biz_a_id, var.sn_biz_c_id ]
  }

  tags  = merge(map("Name", "${var.resrc_prefix_nm}-${var.eks_cluster.name}"), var.extra_tags)
}

resource "aws_eks_node_group" "eks_node" {
  count           = length(var.eks_node_list)
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eks_node_list[count.index].name
  node_role_arn   = var.iam_eks_arn
  subnet_ids      = [ var.sn_biz_a_id, var.sn_biz_c_id ]

  scaling_config {
    desired_size = var.eks_node_list[count.index].desired_size
    max_size     = var.eks_node_list[count.index].max_size
    min_size     = var.eks_node_list[count.index].min_size
  }

  remote_access {
    ec2_ssh_key = var.eks_node_list[count.index].ec2_ssh_key
  }

  tags = {
    Name = "${var.resrc_prefix_nm}-${var.eks_node_list[count.index].name}"
  }

  depends_on = [ var.iam_eks_atm ]
}