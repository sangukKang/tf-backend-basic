# ######################
# COMMON
# ######################
variable "project" {
  default = "mp"
}

variable "env" {
  default = "d"
}

variable "tier" {
  default = "b"
}

variable "region" {
  default = "an2"
}

variable "owner" {
  default = "ugi"
}

variable "cidr" {
  default = "0.0.0.0/0"
}

variable "k8s_key" {
  default = "kubernetes.io/cluster/"
}

variable "eks_val" {
  default = "shared"
}

locals {
  resrc_prefix_nm = "${var.project}-${var.env}${var.tier}${var.region}"
}

locals {
  extra_tags = {
    "Project" = var.project
    "Env"     = var.env
    "Owner"   = var.owner
  }
}

locals {
  eks_key = "${var.k8s_key}${var.project}-${var.env}${var.tier}${var.region}-eks-cluster"
}



# ######################
# VPC
# ######################
variable "vpc" {
  default = {
    cidr_block = "10.60.0.0/16"
    name = "vpc"
  }
}


# ######################
# Subnet
# ######################
variable "sn_pub_list" {
  default = [
    {
      cidr_block = "10.60.1.0/24"
      availability_zone = "ap-northeast-2a"
      name = "irtable"
      az = "a"
    },
    {
      cidr_block = "10.60.2.0/24"
      availability_zone = "ap-northeast-2a"
      name = "irtable"
      az = "c"
    }
  ]
}

variable "sn_pri_az_list" {
  default = [
    {
      cidr_block = "10.60.21.0/24"
      availability_zone = "ap-northeast-2a"
      name = "biz-sub"
      az = "a"
    },
    {
      cidr_block = "10.60.23.0/24"
      availability_zone = "ap-northeast-2a"
      name = "db-sub"
      az = "a"
    },
    {
      cidr_block = "10.60.25.0/24"
      availability_zone = "ap-northeast-2a"
      name = "ecr-sub"
      az = "a"
    }
  ]
}

variable "sn_pri_cz_list" {
  default = [
    {
      cidr_block = "10.60.22.0/24"
      availability_zone = "ap-northeast-2c"
      name = "biz-sub"
      az = "c"
    },
    {
      cidr_block = "10.60.24.0/24"
      availability_zone = "ap-northeast-2c"
      name = "db-sub"
      az = "c"
    },
    {
      cidr_block = "10.60.26.0/24"
      availability_zone = "ap-northeast-2c"
      name = "ecr-sub"
      az = "c"
    }
  ]
}


# ######################
# Route Table
# ######################
variable "rt_pub_list" {
  default = {
    name = "irtable"
    pcx_cidr_block = "10.0.0.0/16"
    pcx_id = "pcx-0c420fe0f7498d7c0"
  }
}

variable "rt_pri_list" {
  default = [
    {
      name = "nrtable"
      az = "a"
      pcx_cidr_block = "10.0.0.0/16"
      pcx_id = "pcx-0c420fe0f7498d7c0"
    },
    {
      name = "nrtable"
      az = "c"
      pcx_cidr_block = "10.0.0.0/16"
      pcx_id = "pcx-0c420fe0f7498d7c0"
    }
  ]
}


# ######################
# Internet Gateway
# ######################
variable "igw" {
  default = {
    name = "vpc-igw"
  }
}


# ######################
# EIP
# ######################
variable "nat_eip_list" {
  default = [
    {
      name = "natgw-eip"
      az = "a"
    },
    {
      name = "natgw-eip"
      az = "c"
    }
  ]
}

variable "bastion_eip" {
  default = {
    name = "bastion-eip"
  }
}


# ######################
# NAT Gateway
# ######################
variable "nat_list" {
  default = [
    {
      name = "natgw"
      az = "a"
    },
    {
      name = "natgw"
      az = "c"
    }
  ]
}

# ######################
# security group
# ######################
variable "bespin_cidr" {
  default = "58.151.93.20/32"
}

variable "sg_bastion" {
  default = {
    name = "sg-bastion"
  }
}

variable "sg_cicd" {
  default = {
    name = "sg-cicd"
  }
}

# ######################
# EC2
# ######################
variable "bastion_ec2" {
  default = {
    name  = "bastion"
    ami   = "ami-0078a04747667d409"
    type  = "t2.micro"
    ip    = "10.60.1.5"
    key   = "k8s-kp-ksu-clm"
  }
}

variable "cicd_ec2" {
  default = {
    name  = "cicd"
    ami   = "ami-0d7c77547cc82875e"
    type  = "t2.medium"
    key   = "k8s-kp-ksu-clm"
  }
}

# ######################
# EKS Cluster
# ######################
variable "aws_iam_role" {
  default = {
    name = "eks-cluster-role"
  }
}

variable "eks_cluster" {
  default = {
    name = "eks-cluster"
  }
}

# ######################
# EKS node group
# ######################
variable "eks_node_group" {
  default = {
    name = "ServiceNodeGroup"
    type = "t3.medium"
    key   = "k8s-kp-ksu-clm"
  }
}

# ######################
# RDS
# ######################
variable "rds_subnet_group" {
  default = {
    name = "db-subnet"
  }
}

variable "rds_cluster" {
  default = {
    cluster_identifier      = "rds-cluster"
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.03.2"
    availability_zones      = ["ap-northeast-2a", "ap-northeast-2c"]
    database_name           = "rds"
    master_username         = "master"
    master_password         = "mastermp"
    backup_retention_period = 35
    preferred_backup_window = "19:15-19:45"
  }
}

variable "rds_cluster_instance" {
  default = [
    {
      name = "az",
      instance_class = "db.t3.small"
    },
    {
      name = "cz",
      instance_class = "db.t3.small"
    }
  ]
}
# ######################
# elasticache
# ######################
variable "redis_subnet" {
  default = {
    name = "redis-subnet"
  }
}

variable "redis_group" {
  default = {
    engine = "redis"
    engine_version = "5.0.4"
    group_id = "redis-cluster"
    group_desc = "redis cluster"
    node_type = "cache.t3.micro"
    port = 6379
    parameter_group = "default.redis5.0"
    automatic_failover_enabled = true
    number_cache_clusters = 3
  }
}
