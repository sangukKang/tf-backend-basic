resource "aws_vpc" "vpc" {
  cidr_block            = var.vpc.cidr_block

  enable_dns_hostnames  = true
  enable_dns_support    = true
  instance_tenancy      = "default"

  tags = merge(map("Name", "${var.resrc_prefix_nm}-vpc"), var.extra_tags)
}