resource "aws_security_group" "sg_bastion" {
  name    = "${var.resrc_prefix_nm}-${var.sg_bastion.name}"
  vpc_id  = aws_vpc.vpc.id

  ingress {
    protocol    = var.sg_bastion.tcp
    from_port   = 22
    to_port     = 22
    cidr_blocks = [ var.ip ]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ var.cidr ]
  }

  tags  = merge(map("Name", "${var.resrc_prefix_nm}-${var.sg_bastion.name}"), var.extra_tags)
}