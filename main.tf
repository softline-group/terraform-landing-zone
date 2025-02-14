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

variable "iam_roles" {
  type = map(object({
    name               = string
    assume_role_policy = string
  }))
  default = {
    admin = {
      name               = "LandingZoneAdmin"
      assume_role_policy = "arn:aws:iam::aws:policy/AdministratorAccess"
    }
    read_only = {
      name               = "LandingZoneReadOnly"
      assume_role_policy = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    }
  }
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

resource "aws_organizations_organization" "org" {
  count = var.enable_aws_organization ? 1 : 0
  feature_set = "ALL"
}

resource "aws_s3_bucket" "config_bucket" {
  count  = var.enable_aws_config ? 1 : 0
  bucket = var.aws_config_delivery_bucket
}

resource "aws_cloudtrail" "trail" {
  count                  = var.enable_aws_cloudtrail ? 1 : 0
  name                   = var.aws_cloudtrail_name
  s3_bucket_name         = var.aws_cloudtrail_bucket_name
  is_multi_region_trail  = true
}

output "aws_organization_id" {
  value = aws_organizations_organization.org[0].id
}

output "aws_cloudtrail_id" {
  value = aws_cloudtrail.trail[0].id
}

output "aws_config_recorder" {
  value = aws_s3_bucket.config_bucket[0].id
}
