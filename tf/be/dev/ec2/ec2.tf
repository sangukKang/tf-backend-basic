/**
  bastion ec2
  bastion 서버는 ip 비활성화 이후 eip 연결
*/
resource "aws_network_interface" "bastion-if" {
  subnet_id       = var.subnet_pub_ids[0]
  private_ips     = [ var.bastion_ec2.ip]
  security_groups = [ var.sg_bastion ]

}

resource "aws_instance" "bastion" {
  ami             = var.bastion_ec2.ami
  instance_type   = var.bastion_ec2.type
  key_name        = var.bastion_ec2.key

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.bastion-if.id
  }

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.bastion_ec2.name}"), var.extra_tags)

}

/**
  cicd ec2
  ami -> kubectl 설치되어 있는 이미지
*/
resource "aws_instance" "cicd" {
  ami               = var.cicd_ec2.ami
  instance_type     = var.cicd_ec2.type
  key_name          = var.cicd_ec2.key

    subnet_id       = var.subnet_pub_ids[0]
    security_groups = [ var.sg_cicd ]
//    associate_public_ip_address = false

  depends_on = [
    var.eks_cluster,
    var.eks_ng_biz
  ]

//  user_data = "${data.template_file.update_config.rendered}"

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.cicd_ec2.name}"), var.extra_tags)

}

//data "template_file" "update_config" {
//  template = "${file("./ec2/update-kubeconfig.tpl")}"
//  //  vars = {
//  //    eks_name = "${var.eks_name}"
//  //  }
//}