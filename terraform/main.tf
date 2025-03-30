resource "aws_ecs_task_definition" "blockchain_app_task" {
  family                   = "blockchain-client"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

#   container_definitions = jsonencode([
#     {
#       name      = ,
#       image     = ,
#       portMappings = [{ containerPort = 8000, hostPort = 8000 }],
#       essential = true
#     }
#   ])

  
}

