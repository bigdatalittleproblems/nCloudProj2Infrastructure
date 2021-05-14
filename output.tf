output "id" {
  value = aws_vpc.main.id
}

output "cidr" {
  value = aws_vpc.main.cidr_block
}

output "default_sg" {
  value = aws_default_security_group.default.id
}

output "default_sg_name" {
  value = aws_default_security_group.default.name
}

output "nat_eips" {
  value = aws_eip.nat.*.public_ip
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.my-cluster.cluster_endpoint
}


output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.my-cluster.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.my-cluster.config_map_aws_auth
}
output "redisendpoint"{
    description = "endpoint for Redis"

  value=aws_elasticache_cluster.projectcache.cache_nodes.address
}

# output "redis_endpoint" {
#   value = data.aws_elasticache_cluster.example.redis_endpoint
# }{}
