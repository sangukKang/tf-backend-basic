terraform {
  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                  = "ap-northeast-2"
  shared_credentials_file = "~/.aws/credentials"
}

module "vpc" {
  source = "./vpc"

  resrc_prefix_nm = local.resrc_prefix_nm
  extra_tags      = local.extra_tags
  cidr            = var.cidr
  ip              = var.ip

  vpc             = var.vpc
  sn_pub_list     = var.sn_pub_list
  sn_pri_a_list   = var.sn_pri_a_list
  sn_pri_c_list   = var.sn_pri_c_list
  rt_pub_list     = var.rt_pub_list
  rt_pri_list     = var.rt_pri_list
  igw             = var.igw
  eip_nat_ids     = module.ec2.eip_nat_ids
  nat_list        = var.nat_list
  sg_bastion      = var.sg_bastion
}

module "ec2" {
  source = "./ec2"

  resrc_prefix_nm = local.resrc_prefix_nm
  extra_tags      = local.extra_tags

  sn_pub_a_id     = module.vpc.sn_pub_a_id
  eip_nat_list    = var.eip_nat_list
  eip_bastion     = var.eip_bastion
  ec2_bastion     = var.ec2_bastion
  sg_bastion_id   = module.vpc.sg_bastion_id
}

module "eks" {
  source = "./eks"

  resrc_prefix_nm = local.resrc_prefix_nm
  extra_tags      = local.extra_tags

  eks_cluster     = var.eks_cluster
  eks_node_list   = var.eks_node_list
  sn_pub_a_id     = module.vpc.sn_pub_a_id
  sn_pub_c_id     = module.vpc.sn_pub_c_id
  sn_biz_a_id     = module.vpc.sn_biz_a_id
  sn_biz_c_id     = module.vpc.sn_biz_c_id
  iam_eks_arn     = module.iam.iam_eks_arn
  iam_eks_atm     = module.iam.iam_eks_atm
}

module "iam" {
  source = "./iam"

  resrc_prefix_nm = local.resrc_prefix_nm
  extra_tags      = local.extra_tags

  iam_eks         = var.iam_eks
}

module "rds" {
  source = "./rds"

  resrc_prefix_nm = local.resrc_prefix_nm
  extra_tags      = local.extra_tags

  rds_cluster     = var.rds_cluster
  sn_db_a_id      = module.vpc.sn_db_a_id
  sn_db_c_id      = module.vpc.sn_db_c_id
}

module "elasticache" {
  source = "./elasticache"

  resrc_prefix_nm = local.resrc_prefix_nm
  extra_tags      = local.extra_tags

  redis_cluster   = var.redis_cluster
  sn_ecr_a_id     = module.vpc.sn_ecr_a_id
  sn_ecr_c_id     = module.vpc.sn_ecr_c_id
}