resource "aws_elasticache_subnet_group" "ec_sn_ecr" {
  name       = var.redis_cluster.subnet_group_name
  subnet_ids = [ var.sn_ecr_a_id, var.sn_ecr_c_id ]
}

resource "aws_elasticache_replication_group" "redis_replication_group" {
  engine                        = var.redis_cluster.engine
  engine_version                = var.redis_cluster.engine_version
  replication_group_id          = "${var.resrc_prefix_nm}-${var.redis_cluster.name}"
  replication_group_description = "${var.resrc_prefix_nm}-${var.redis_cluster.name}"
  subnet_group_name             = aws_elasticache_subnet_group.ec_sn_ecr.name
  node_type                     = var.redis_cluster.node_type
  port                          = var.redis_cluster.port
  parameter_group_name          = var.redis_cluster.parameter_group_name
  automatic_failover_enabled    = var.redis_cluster.automatic_failover_enabled
  number_cache_clusters         = var.redis_cluster.number_cache_clusters

  lifecycle {
    ignore_changes = [ number_cache_clusters ]
  }

  tags  = merge(map("Name", "${var.resrc_prefix_nm}-${var.redis_cluster.name}"), var.extra_tags)
}