# resource "aws_iam_service_linked_role" "es" {
#   aws_service_name = "es.amazonaws.com"
# }
# resource "aws_elasticsearch_domain" "example" {
#   domain_name           = "example"
#   elasticsearch_version = "7.10"

#   cluster_config {
#     instance_type = "t2.small.elasticsearch"
#   }
#   vpc_options {
#     subnet_ids = [
#       aws_subnet.private[0].id
#     ]
#   }

#   snapshot_options {
#     automated_snapshot_start_hour = 23
#   }
#   ebs_options {
#     ebs_enabled = true
#     volume_size = 30
#     volume_type = "gp2"
#   }
#   tags = {
#     Domain = "TestDomain"
#   }
#   depends_on = [aws_iam_service_linked_role.es]
# }
resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
}