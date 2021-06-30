resource "aws_eks_cluster" "eks-cluster" {
//  name     = "example"
  name = "${var.resrc_prefix_nm}-${var.eks_cluster.name}"
  role_arn = var.iam_role.arn

  vpc_config {
    subnet_ids = concat(var.subnet_pub_ids, [var.subnet_pri_az_ids[0]], [var.subnet_pri_cz_ids[0]])
    security_group_ids = [ aws_security_group.sg-eks.id ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.eks_cluster_policy,
    var.eks_vpc_resource_controller
  ]

  version = "1.18"

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.eks_cluster.name}"), var.extra_tags)

}