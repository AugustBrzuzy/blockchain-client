
data "aws_subnet" "ecs_subnet" {
  id = var.subnet_id
}

data "aws_security_group" "ecs_sg" {
  id = var.security_group_id
}

data "aws_ecs_cluster" "ecs-blockchain" {
  cluster_name = "ecs-blockchain"
}