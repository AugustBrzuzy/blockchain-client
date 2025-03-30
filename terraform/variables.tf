variable "aws_region" {
    description = "The AWS region where the ECS service will be deployed."
    type        = string
    default     = "us-east-1" # Replace with your actual AWS region
    validation {
        condition     = length(var.aws_region) > 0
        error_message = "The AWS region must not be empty."
    }
}

variable "ecr_name" {
    description = "The name of the Amazon ECR repository."
    type        = string
    default     = "blockchain-client" # Replace with your actual ECR repository name
    validation {
        condition     = length(var.acr_name) > 0
        error_message = "The ECR repository name must not be empty."
    }
}

variable "subnet_id" {
    description = "The ID of the subnet where the ECS service will be deployed."
    type        = string
    default    = "subnet-12345678" # Replace with your actual subnet ID
    validation {
        condition     = length(var.subnet_id) > 0
        error_message = "The subnet ID must not be empty."
    }
}

variable "security_group_id" {
    description = "The ID of the security group to associate with the ECS service."
    type        = string
    default    = "sg-12345678" # Replace with your actual security group ID
    validation {
        condition     = length(var.security_group_id) > 0
        error_message = "The security group ID must not be empty."
    }
}
