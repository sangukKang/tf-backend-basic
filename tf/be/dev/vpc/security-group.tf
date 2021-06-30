resource "aws_security_group" "sg-bastion" {
  name        = "${var.resrc_prefix_nm}-${var.sg_bastion.name}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = [ var.bespin_cidr ]
  }

  egress {
    protocol  = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.sg_bastion.name}"), map("kubernetes.io/cluster/kubernetes", "shared"), var.extra_tags)
}

resource "aws_security_group" "sg-cicd" {
  name        = "${var.resrc_prefix_nm}-${var.sg_cicd.name}"
  vpc_id      = aws_vpc.vpc.id

//  ingress {
//    protocol  = "tcp"
//    from_port = 22
//    to_port   = 22
//    cidr_blocks = [ "10.60.1.0/24" ]
//  }
  /**
    임시로 전체 오픈 GIT 사용을 위해서
  */
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

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.sg_cicd.name}"), map("kubernetes.io/cluster/kubernetes", "shared"), var.extra_tags)
}