variable "resrc_prefix_nm" {}
variable "extra_tags" {}

variable "iam_role" {}
variable "eks_cluster_policy" {}
variable "eks_vpc_resource_controller" {}

variable "eks_cluster" {}
variable "subnet_pub_ids" {}
variable "subnet_pri_az_ids" {}
variable "subnet_pri_cz_ids" {}
variable "vpc_id" {}
variable "eks_node_group" {}
variable "node_role" {}
variable "eks_node_policy" {}
variable "eks_node_cni_policy" {}