terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/admin-machine.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  version = "~> 2.69"
  region  = "eu-west-1"
}

module "admin-machine" {
  source = "../modules/admin-machine"
}
