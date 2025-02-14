variable "enable_aws_organization" {
  type    = bool
  default = true
}

variable "organization_units" {
  type    = list(string)
  default = ["Security", "Infrastructure", "Development", "Production"]
}

variable "enable_aws_config" {
  type    = bool
  default = true
}

variable "aws_config_recorder_name" {
  type    = string
  default = "default"
}

variable "aws_config_delivery_bucket" {
  type    = string
  default = "landing-zone-config-bucket"
}

variable "enable_aws_cloudtrail" {
  type    = bool
  default = true
}

variable "aws_cloudtrail_name" {
  type    = string
  default = "landing-zone-trail"
}

variable "aws_cloudtrail_bucket_name" {
  type    = string
  default = "landing-zone-cloudtrail-bucket"
}

variable "enable_iam_roles" {
  type    = bool
  default = true
}

variable "enable_aws_sso" {
  type    = bool
  default = true
}

variable "aws_sso_users" {
  type    = list(string)
  default = ["admin@company.com", "devops@company.com"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "enable_vpc" {
  type    = bool
  default = true
}

variable "enable_subnets" {
  type    = bool
  default = true
}

variable "enable_sg" {
  type    = bool
  default = true
}
