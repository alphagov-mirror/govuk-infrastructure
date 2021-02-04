output "cli_input_json" {
  value = {
    containerDefinitions    = var.container_definitions,
    cpu                     = var.cpu,
    executionRoleArn        = var.execution_role_arn,
    family                  = var.family,
    memory                  = var.memory,
    networkMode             = "awsvpc",
    proxyConfiguration      = var.proxy_configuration
    requiresCompatibilities = ["FARGATE"],
    taskRoleArn             = var.task_role_arn,
  }
}
