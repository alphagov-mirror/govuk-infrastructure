terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/router.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.69"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "task_definition" {
  source             = "../../../../modules/task-definitions/router"
  image_tag          = var.image_tag
  mesh_name          = local.mesh_name
  execution_role_arn = data.aws_iam_role.execution.arn
  mongodb_host       = "router-backend-1.test.govuk-internal.digital,router-backend-2.test.govuk-internal.digital,router-backend-3.test.govuk-internal.digital"
  task_role_arn      = data.aws_iam_role.task.arn
  sentry_environment = "test"
}
