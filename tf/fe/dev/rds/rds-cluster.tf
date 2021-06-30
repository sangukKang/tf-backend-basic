resource "aws_db_subnet_group" "sn_db" {
  name        = var.rds_cluster.db_subnet_group_name
  subnet_ids  = [ var.sn_db_a_id, var.sn_db_c_id ]

  tags        = merge(map("Name", "${var.resrc_prefix_nm}-${var.rds_cluster.db_subnet_group_name}"), var.extra_tags)
}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier      = "${var.resrc_prefix_nm}-${var.rds_cluster.name}"
  engine                  = var.rds_cluster.engine
  engine_version          = var.rds_cluster.engine_version
  availability_zones      = var.rds_cluster.availability_zones
  db_subnet_group_name    = aws_db_subnet_group.sn_db.name
  database_name           = var.rds_cluster.database_name
  master_username         = var.rds_cluster.master_username
  master_password         = var.rds_cluster.master_password
  backup_retention_period = var.rds_cluster.backup_retention_period
  preferred_backup_window = var.rds_cluster.preferred_backup_window
  skip_final_snapshot     = var.rds_cluster.skip_final_snapshot

  lifecycle {
    ignore_changes = [ availability_zones ]
  }

  tags  = merge(map("Name", "${var.resrc_prefix_nm}-${var.rds_cluster.name}"), var.extra_tags)
}

resource "aws_rds_cluster_instance" "cluster_instance" {
  count                 = length(var.rds_cluster.availability_zones)
  cluster_identifier    = aws_rds_cluster.rds_cluster.id
  instance_class        = var.rds_cluster.instance_class
  engine                = aws_rds_cluster.rds_cluster.engine
  engine_version        = aws_rds_cluster.rds_cluster.engine_version
  db_subnet_group_name  = aws_db_subnet_group.sn_db.name

  tags  = merge(map("Name", "${var.resrc_prefix_nm}-${var.rds_cluster.name}"), var.extra_tags)
}