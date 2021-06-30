variable "resrc_prefix_nm" {}
variable "extra_tags" {}
variable "nat_eip_list" {}

variable "bastion_ec2" {}
variable "bastion_eip" {}
variable "cicd_ec2" {}

variable "sg_bastion" {}
variable "sg_cicd" {}
variable "subnet_pub_ids" {}
variable "eks_cluster" {}
variable "eks_ng_biz" {}
variable "eks_name" {}