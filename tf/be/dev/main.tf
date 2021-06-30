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

  resrc_prefix_nm   = local.resrc_prefix_nm
  extra_tags        = local.extra_tags
  eks_key           = local.eks_key
  eks_val           = var.eks_val

  vpc               = var.vpc
  nat_list          = var.nat_list
  rt_pri_list       = var.rt_pri_list
  rt_pub_list       = var.rt_pub_list
  sn_pri_az_list    = var.sn_pri_az_list
  sn_pri_cz_list    = var.sn_pri_cz_list
  sn_pub_list       = var.sn_pub_list
  igw               = var.igw
  sg_bastion        = var.sg_bastion
  sg_cicd           = var.sg_cicd
  bespin_cidr       = var.bespin_cidr

  nat_eip           = module.ec2.nat_eip

}

/**
  IAM
*/
module "iam" {
  source = "./iam"

  resrc_prefix_nm   = local.resrc_prefix_nm
  extra_tags        = local.extra_tags

  aws_iam_role = var.aws_iam_role
}

/**
  EKS
*/
module "eks" {
  source = "./eks"

  resrc_prefix_nm             = local.resrc_prefix_nm
  extra_tags                  = local.extra_tags

  eks_cluster_policy          = module.iam.eks_cluster_policy
  eks_vpc_resource_controller = module.iam.eks_vpc_resource_controller
  iam_role                    = module.iam.iam_role
  subnet_pub_ids              = module.vpc.subnet_pub_ids
  subnet_pri_az_ids           = module.vpc.subnet_pri_az_ids
  subnet_pri_cz_ids           = module.vpc.subnet_pri_cz_ids
  vpc_id                      = module.vpc.vpc_id
  node_role                   = module.iam.node_role
  eks_node_policy             = module.iam.eks_node_policy
  eks_node_cni_policy         = module.iam.eks_node_cni_policy

  eks_cluster                 = var.eks_cluster
  eks_node_group              = var.eks_node_group
}

module "ec2" {
  source = "./ec2"

  resrc_prefix_nm   = local.resrc_prefix_nm
  extra_tags        = local.extra_tags

  nat_eip_list      = var.nat_eip_list
  bastion_ec2       = var.bastion_ec2
  bastion_eip       = var.bastion_eip
  cicd_ec2          = var.cicd_ec2

  subnet_pub_ids    = module.vpc.subnet_pub_ids
  sg_bastion        = module.vpc.sg_bastion
  sg_cicd           = module.vpc.sg_cicd
  eks_cluster       = module.eks.eks_cluster
  eks_ng_biz        = module.eks.eks_ng_biz
  eks_name          = module.eks.eks_name

}

module "rds" {
  source = "./rds"

  resrc_prefix_nm       = local.resrc_prefix_nm
  extra_tags            = local.extra_tags

  rds_subnet_group      = var.rds_subnet_group
  rds_cluster           = var.rds_cluster
  rds_cluster_instance  = var.rds_cluster_instance

  subnet_pri_az_ids     = module.vpc.subnet_pri_az_ids
  subnet_pri_cz_ids     = module.vpc.subnet_pri_cz_ids
}

module "redis" {
  source = "./elasticache"

  resrc_prefix_nm       = local.resrc_prefix_nm
  extra_tags            = local.extra_tags

  redis_group = var.redis_group
  redis_subnet = var.redis_subnet

  subnet_pri_az_ids     = module.vpc.subnet_pri_az_ids
  subnet_pri_cz_ids     = module.vpc.subnet_pri_cz_ids
}