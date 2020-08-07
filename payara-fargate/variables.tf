variable "aws_region" {
  description = "The AWS region things are created in"
  default = "eu-central-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "jeeEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role name"
  default = "jeeEcsAutoScaleRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default = "3"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default = "lreimer/jakartaee8-java11:d412e89362d3ee78e3e70fc29caf4689a84caa36c9652910a301654f8c7472fa"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default = 8080
}

variable "app_count" {
  description = "Number of docker containers to run"
  default = 3
}

variable "health_check_path" {
  default = "/health"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default = "2048"
}
