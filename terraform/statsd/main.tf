terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/statsd.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  version = "~> 2.69"
  region  = "eu-west-1"
}

variable "internal_domain_name" {
  description = "The internal root root domain name"
  type        = string
  default     = "test.govuk-internal.digital"
}

data "aws_route53_zone" "internal" {
  name         = var.internal_domain_name
  private_zone = true
}

module "infra_fargate" {
  source                = "../modules/infra-fargate"
  service_name          = "statsd"
  container_definitions = file("../task-definitions/statsd.json")
  desired_count         = 1
}

resource "aws_route53_record" "statsd_internal_service_names" {
  zone_id = data.aws_route53_zone.internal.zone_id
  name    = "statsd.${var.internal_domain_name}"
  type    = "CNAME"
  records = ["statsd.pink.${var.internal_domain_name}"]
  ttl     = "300"
}

resource "aws_route53_record" "statsd_internal_service_record" {
  zone_id = data.aws_route53_zone.internal.zone_id
  name    = "statsd.${var.internal_domain_name}"
  type    = "A"

  alias {
    name                   = module.infra_fargate.dns_name
    zone_id                = module.infra_fargate.alb_zone_id
    evaluate_target_health = true
  }
}

# TODO: Refactor security groups of infra-fargate a bit more...
# There are security groups in there that should be in the module
