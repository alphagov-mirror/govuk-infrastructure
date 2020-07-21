variable "govuk_management_access_security_group" {
  description = "Group used to allow access by management systems"
  type        = string
  default     = "sg-0b873470482f6232d"
}

variable "private_subnet" {
  description = "The subnet id for govuk_private_a"
  type        = string
  default     = "subnet-6dc4370b"
}
