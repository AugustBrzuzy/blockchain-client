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
