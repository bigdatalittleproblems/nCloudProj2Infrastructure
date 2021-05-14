module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.17"
  subnets         = aws_subnet.private.*.id
  vpc_id          = aws_vpc.main.id
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.micro"
      asg_desired_capacity          = 1
      asg_max_size                  = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.micro"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
      asg_max_size                  = 2
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}