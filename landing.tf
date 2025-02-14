terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

module "aws_landing_zone" {
  source = "./modules/aws_landing_zone"

  # AWS Organization Setup
  enable_aws_organization = true
  organization_units      = ["Security", "Infrastructure", "Development", "Production"]

  # AWS Config Setup
  enable_aws_config         = true
  aws_config_recorder_name  = "default"
  aws_config_delivery_bucket = "landing-zone-config-bucket"

  # AWS CloudTrail Setup
  enable_aws_cloudtrail       = true
  aws_cloudtrail_name         = "landing-zone-trail"
  aws_cloudtrail_bucket_name  = "landing-zone-cloudtrail-bucket"

  # AWS IAM Roles and Permissions
  enable_iam_roles = true
  iam_roles = {
    admin = {
      name               = "LandingZoneAdmin"
      assume_role_policy = "arn:aws:iam::aws:policy/AdministratorAccess"
    }
    read_only = {
      name               = "LandingZoneReadOnly"
      assume_role_policy = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    }
  }

  # AWS Single Sign-On (SSO)
  enable_aws_sso = true
  aws_sso_users  = ["admin@company.com", "devops@company.com"]

  # Security Components
  enable_guardduty       = true
  enable_security_hub     = true
  enable_aws_shield       = true
  enable_aws_waf          = true

  # Networking (VPC, Subnet, Security Groups)
  vpc_cidr          = "10.0.0.0/16"
  enable_vpc        = true
  enable_subnets    = true
  enable_sg        = true

  subnets = {
    public = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
    }
    private = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
    }
  }

  security_groups = {
    allow_all = {
      description = "Allow all inbound and outbound traffic"
      ingress = [
        {
          protocol  = "tcp"
          from_port = 0
          to_port   = 65535
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          protocol  = "-1"
          from_port = 0
          to_port   = 0
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}

output "aws_organization_id" {
  value = module.aws_landing_zone.aws_organization_id
}

output "aws_cloudtrail_id" {
  value = module.aws_landing_zone.aws_cloudtrail_id
}

output "aws_config_recorder" {
  value = module.aws_landing_zone.aws_config_recorder
}
