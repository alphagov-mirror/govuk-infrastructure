variable "external_route53_zone_id" {
  type        = string
  description = "e.g. default.test.govuk.digital. Domain in which to create DNS records for the app's Internet-facing load balancer."
}

variable "external_app_domain_certificate_arn" {
  type        = string
  description = "Wildard certificate ARN, e.g. for *.default.test.govuk.digital."
}

variable "app_name" {
  type        = string
  description = "A GOV.UK application name. E.g. publisher, content-publisher"
}

variable "dns_a_record_name" {
  type        = string
  description = "DNS A Record name. Should be cluster and environment-aware."
}

variable "external_cidrs_list" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "public_subnets" {
  type = list(any)
}

variable "service_security_group_id" {
  type        = string
  description = "Security group ID for the associated ECS Service."
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/healthcheck"
}

variable "target_port" {
  type    = number
  default = 80
}
