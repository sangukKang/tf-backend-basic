/**
  public subnet
*/
resource "aws_subnet" "sn-pub" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.sn_pub_list)
  cidr_block              = lookup(var.sn_pub_list[count.index], "cidr_block")
  availability_zone       = lookup(var.sn_pub_list[count.index], "availability_zone")
  map_public_ip_on_launch = true

  tags = merge(
    map("Name", "${var.resrc_prefix_nm}${lookup(var.sn_pub_list[count.index], "az")}-${lookup(var.sn_pub_list[count.index], "name")}"),
    var.extra_tags,
    map(var.eks_key, var.eks_val)
  )
}
/**
  private subnet az
*/
resource "aws_subnet" "sn-az-pri" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.sn_pri_az_list)
  cidr_block              = lookup(var.sn_pri_az_list[count.index], "cidr_block")
  availability_zone       = lookup(var.sn_pri_az_list[count.index], "availability_zone")
//  map_public_ip_on_launch = true

  tags = merge(
    map("Name", "${var.resrc_prefix_nm}${lookup(var.sn_pri_az_list[count.index], "az")}-${lookup(var.sn_pri_az_list[count.index], "name")}"),
    var.extra_tags,
    map("az", lookup(var.sn_pri_az_list[count.index], "az")),
    map(var.eks_key, var.eks_val)
  )
}
/**
  private subnet cz
*/
resource "aws_subnet" "sn-cz-pri" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.sn_pri_cz_list)
  cidr_block              = lookup(var.sn_pri_cz_list[count.index], "cidr_block")
  availability_zone       = lookup(var.sn_pri_cz_list[count.index], "availability_zone")
//  map_public_ip_on_launch = true

  tags = merge(
    map("Name", "${var.resrc_prefix_nm}${lookup(var.sn_pri_cz_list[count.index], "az")}-${lookup(var.sn_pri_cz_list[count.index], "name")}"),
    var.extra_tags,
    map("az", lookup(var.sn_pri_cz_list[count.index], "az")),
    map(var.eks_key, var.eks_val)
  )
}