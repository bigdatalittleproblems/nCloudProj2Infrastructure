resource "aws_elasticache_cluster" "projectcache" {
  cluster_id           = "projectcache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.projectcacheprivate.name

}

resource "aws_elasticache_subnet_group" "projectcacheprivate" {
  name       = "projectcacheprivate-subnet"
  subnet_ids = aws_subnet.private.*.id
}