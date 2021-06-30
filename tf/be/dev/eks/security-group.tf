resource "aws_security_group" "sg-eks" {
  name        = "${var.eks_cluster.name}-${var.resrc_prefix_nm}-sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    protocol  = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = merge(map("Name", "${var.eks_cluster.name}-${var.resrc_prefix_nm}-sg"), map("kubernetes.io/cluster/kubernetes", "shared"), var.extra_tags)
}

resource "aws_security_group" "sg-eks-node" {
  name        = "${var.eks_cluster.name}-${var.resrc_prefix_nm}-node-sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    protocol  = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = merge(map("Name", "${var.eks_cluster.name}-${var.resrc_prefix_nm}-sg"), map("kubernetes.io/cluster/kubernetes", "shared"), var.extra_tags)
}