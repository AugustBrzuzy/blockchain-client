## assumption is that there is a pre-existing central ECS cluster
## adding ECS task definition and ECS service to the existing cluster per the requirement on given app to be deployed
## also expecting a separate infra layer for networking and security group creation that precedes this module

data "aws_subnet" "ecs_subnet" {
  id = var.subnet_id
}

data "aws_security_group" "ecs_sg" {
  id = var.security_group_id
}

data "aws_ecs_cluster" "ecs-blockchain" {
  cluster_name = "ecs-blockchain"
}