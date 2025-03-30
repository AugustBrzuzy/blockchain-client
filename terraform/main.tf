resource "aws_ecs_task_definition" "blockchain_app_task" {
  family                   = "blockchain-client"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "blockchain-client",
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${ecr_name}:latest",
      portMappings = [{ containerPort = 8000, hostPort = 8000 }],
      essential = true
    }
  ])

    ## necessary while using Fargate compatibility
    runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}
