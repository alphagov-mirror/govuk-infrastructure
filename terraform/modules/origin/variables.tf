variable "external_app_domain" {
  type        = string
  description = "e.g. test.govuk.digital. Domain in which to create DNS records for the app's Internet-facing load balancer."
}

variable "certificate" {
  type = string
}

variable "live" {
  description = "Determines whether the origin is a live or a draft one"
  type        = bool
  default     = true
}

variable "apps_security_config_list" {
  type        = map(any)
  description = "map in the format {<app_name> = { security_group_id=<security_group_id>, target_port=<target_port>}}"
}

variable "cidrs_allowlist" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "publishing_service_domain" {
  type        = string
  description = "e.g. test.publishing.service.gov.uk"
}

variable "public_subnets" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

variable "public_zone_id" {
  type = string
}

variable "workspace" {
  type = string
}
