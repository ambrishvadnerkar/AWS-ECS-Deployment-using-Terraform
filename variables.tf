variable "aws_region" {
    description = "The AWS region things are created in"
    default = "us-east-1"
}
variable "vpc_cidr" {
    description = "Network CIDR range for BPC"
    default = "172.17.0.0/16"
}


variable "ec2_task_execution_role_name" {
    description = "ECS task execution role name"
    default = "myEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
    description = "ECS auto scale role name"
    default = "myEcsAutoScaleRole"
}

variable "az_count" {
    description = "Number of AZs to cover in a given region"
    default = "2"
}

variable "app_image" {
    description = "Docker image to run in the ECS cluster"
    default = "851246253769.dkr.ecr.us-east-1.amazonaws.com/flask-app:a36850fa72d05357d891670815019f370beced90"
}

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 5000

}

variable "app_count" {
    description = "Number of docker containers to run"
    default = 3
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default = "1024"
}

variable "fargate_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default = "2048"
}