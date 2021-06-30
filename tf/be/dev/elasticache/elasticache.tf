resource "aws_elasticache_subnet_group" "redis-subnet" {
  name       = "${var.resrc_prefix_nm}-${var.redis_subnet.name}"
  subnet_ids = [ var.subnet_pri_az_ids[2], var.subnet_pri_cz_ids[2] ]
//  subnet_ids = concat([var.subnet_pri_az_ids[2]], [var.subnet_pri_cz_ids[2]])
}

resource "aws_elasticache_replication_group" "redis-group" {
  engine                        = var.redis_group.engine
  engine_version                = var.redis_group.engine_version
  replication_group_id          = "${var.resrc_prefix_nm}-${var.redis_group.group_id}"
  replication_group_description = var.redis_group.group_desc
  node_type                     = var.redis_group.node_type
  port                          = var.redis_group.port
  parameter_group_name          = var.redis_group.parameter_group
  automatic_failover_enabled    = var.redis_group.automatic_failover_enabled
  subnet_group_name             = aws_elasticache_subnet_group.redis-subnet.name
  number_cache_clusters         = var.redis_group.number_cache_clusters

  lifecycle {
    ignore_changes = [number_cache_clusters]
  }

}