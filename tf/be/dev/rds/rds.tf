resource "aws_db_subnet_group" "rds-subnet" {
  name       = "${var.resrc_prefix_nm}-${var.rds_subnet_group.name}"
  subnet_ids = [ var.subnet_pri_az_ids[1], var.subnet_pri_cz_ids[1] ]

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.rds_subnet_group.name}"), var.extra_tags)
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier      = "${var.resrc_prefix_nm}-${var.rds_cluster.cluster_identifier}"
  engine                  = var.rds_cluster.engine
  engine_version          = var.rds_cluster.engine_version
  availability_zones      = var.rds_cluster.availability_zones
  database_name           = var.rds_cluster.database_name
  master_username         = var.rds_cluster.master_username
  master_password         = var.rds_cluster.master_password
  backup_retention_period = var.rds_cluster.backup_retention_period
  preferred_backup_window = var.rds_cluster.preferred_backup_window
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.rds-subnet.name

  lifecycle {
    ignore_changes = [ availability_zones ]
  }
}

resource "aws_rds_cluster_instance" "cluster-instances" {
  count                 = length(var.rds_cluster_instance)
  identifier            = "${var.resrc_prefix_nm}-${var.rds_cluster.cluster_identifier}-${var.rds_cluster_instance.*.name[count.index]}"
  cluster_identifier    = aws_rds_cluster.cluster.id
  instance_class        = var.rds_cluster_instance.*.instance_class[count.index]
  engine                = aws_rds_cluster.cluster.engine
  engine_version        = aws_rds_cluster.cluster.engine_version
  db_subnet_group_name  = aws_db_subnet_group.rds-subnet.name
}
