resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.igw.name}"), var.extra_tags)
}