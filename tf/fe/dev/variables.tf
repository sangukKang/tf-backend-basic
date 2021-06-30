# ######################
# COMMON
# ######################
variable "pj" {
  default = "mp"
}

variable "project" {
  default = "MarketPlace"
}

variable "env" {
  default = "d"
}

variable "environment" {
  default = "Dev"
}

variable "tier" {
  default = "f"
}

variable "region" {
  default = "an2"
}

variable "owner" {
  default = "ming"
}

variable "cidr" {
  default = "0.0.0.0/0"
}

variable "ip" {
  default = "58.151.93.20/32"
}

locals {
  resrc_prefix_nm = "${var.pj}-${var.env}${var.tier}${var.region}"
}

locals {
  extra_tags = {
    "Project" = var.project
    "Env"     = var.environment
    "Owner"   = var.owner
  }
}


# ######################
# VPC
# ######################
variable "vpc" {
  default = {
    name = "vpc"
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
  }
}


# ######################
# Subnet
# ######################
variable "sn_pub_list" {
  default = [
    {
      name = "pub-sub"
      cidr_block = "10.0.1.0/24"
      availability_zone = "ap-northeast-2a"
      az = "a"
    },
    {
      name = "pub-sub"
      cidr_block = "10.0.2.0/24"
      availability_zone = "ap-northeast-2c"
      az = "c"
    }
  ]
}

variable "sn_pri_a_list" {
  default = [
    {
      name = "waf-sub"
      cidr_block = "10.0.15.0/24"
      availability_zone = "ap-northeast-2a"
      az = "a"
    },
    {
      name = "biz-sub"
      cidr_block = "10.0.21.0/24"
      availability_zone = "ap-northeast-2a"
      az = "a"
    },
    {
      name = "db-sub"
      cidr_block = "10.0.101.0/24"
      availability_zone = "ap-northeast-2a"
      az = "a"
    },
    {
      name = "ecr-sub"
      cidr_block = "10.0.201.0/24"
      availability_zone = "ap-northeast-2a"
      az = "a"
    }
  ]
}

variable "sn_pri_c_list" {
  default = [
    {
      name = "waf-sub"
      cidr_block = "10.0.16.0/24"
      availability_zone = "ap-northeast-2c"
      az = "c"
    },
    {
      name = "biz-sub"
      cidr_block = "10.0.22.0/24"
      availability_zone = "ap-northeast-2c"
      az = "c"
    },
    {
      name = "db-sub"
      cidr_block = "10.0.102.0/24"
      availability_zone = "ap-northeast-2c"
      az = "c"
    },
    {
      name = "ecr-sub"
      cidr_block = "10.0.202.0/24"
      availability_zone = "ap-northeast-2c"
      az = "c"
    }
  ]
}


# ######################
# Route Table
# ######################
variable "rt_pub_list" {
  default = {
    name = "rt"
    pcx_cidr_block = "10.1.0.0/16"
    pcx_id = "pcx-01c66c5dbb513ab62"
  }
}

variable "rt_pri_list" {
  default = [
    {
      name = "rt"
      az = "a"
      pcx_cidr_block = "10.1.0.0/16"
      pcx_id = "pcx-01c66c5dbb513ab62"
    },
    {
      name = "rt"
      az = "c"
      pcx_cidr_block = "10.1.0.0/16"
      pcx_id = "pcx-01c66c5dbb513ab62"
    }
  ]
}


# ######################
# Internet Gateway
# ######################
variable "igw" {
  default = {
    name = "igw"
  }
}


# ######################
# EIP
# ######################
variable "eip_nat_list" {
  default = [
    {
      name = "nat-eip"
      az = "a"
      vpc = true
    },
    {
      name = "nat-eip"
      az = "c"
      vpc = true
    }
  ]
}

variable "eip_bastion" {
  default = {
    name = "bastion-eip"
    vpc = true
  }
}


# ######################
# NAT Gateway
# ######################
variable "nat_list" {
  default = [
    {
      name = "nat"
      az = "a"
    },
    {
      name = "nat"
      az = "c"
    }
  ]
}


# ######################
# Security Group
# ######################
variable "sg_bastion" {
  default = {
    name = "bastion-sg"
    tcp = "TCP"
  }
}


# ######################
# EKS
# ######################
variable "eks_cluster" {
  default = {
    name = "eks-cluster"
  }
}

variable "eks_node_list" {
  default = [
    {
      name = "ServiceNodeGroup"
      ec2_ssh_key = "ming-opsflex"
      desired_size = 2
      max_size = 2
      min_size = 2
    },
    {
      name = "ManagementNodeGroup"
      ec2_ssh_key = "ming-opsflex"
      desired_size = 2
      max_size = 2
      min_size = 2
    }
  ]
}


# ######################
# IAM
# ######################
variable "iam_eks" {
  default = {
    name = "eks-iam"
    policy_list = [
      { arn : "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" },
      { arn : "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"},
      { arn : "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"},
      { arn : "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"},
      { arn : "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"}
    ]
  }
}


# ######################
# Instance
# ######################
variable "ec2_bastion" {
  default = {
    name = "bastion"
    instance_type = "t3.medium"
    ami = "ami-08bd8a58e291d381f"
    key_name = "ming-opsflex"
    associate_public_ip_address = true
  }
}


# ######################
# RDS
# ######################
variable "rds_cluster" {
  default = {
    name = "rds-cluster"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.03.2"
    availability_zones = [ "ap-northeast-2a", "ap-northeast-2c" ]
    database_name = "rds"
    master_username = "master"
    master_password = "mastermp"
    backup_retention_period = 35
    preferred_backup_window = "19:15-19:45"
    db_subnet_group_name = "db-sub"
    skip_final_snapshot = true
    instance_class = "db.r5.xlarge"
    az = [ "a", "c" ]
  }
}


# ######################
# Elastic Cache
# ######################
variable "redis_cluster" {
  default = {
    name = "redis-cluster"
    engine = "redis"
    node_type = "cache.r5.2xlarge"
    parameter_group_name = "default.redis5.0"
    engine_version = "5.0.4"
    port = 6379
    subnet_group_name = "ecr-sub"
    replicas_per_node_group = 2
    num_node_groups = 1
    automatic_failover_enabled = true
    number_cache_clusters = 3
  }
}