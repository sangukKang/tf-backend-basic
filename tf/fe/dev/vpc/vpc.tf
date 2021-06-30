resource "aws_vpc" "vpc" {
  cidr_block            = var.vpc.cidr_block

  enable_dns_hostnames  = var.vpc.enable_dns_hostnames
  enable_dns_support    = var.vpc.enable_dns_support
  instance_tenancy      = var.vpc.instance_tenancy

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.vpc.name}"), var.extra_tags)
}