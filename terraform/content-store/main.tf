terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/app-content-store.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  version = "~> 2.69"
  region  = "eu-west-1"
}

module "infra-fargate" {
  source                 = "../modules/infra-fargate"
  service_name           = "content-store"
  container_definitions  = file("content-store.json")
  desired_count          = 1
  container_ingress_port = 80
}

module "fargate-console" {
  source                = "../modules/fargate-console"
  service_name          = "content-store-console"
  container_definitions = file("content-store-console.json")
}
