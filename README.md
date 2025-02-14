# AWS Landing Zone Terraform Module

## Overview
This Terraform module sets up an AWS Landing Zone environment with security best practices. It provisions essential AWS services, including AWS Organizations, AWS Config, AWS CloudTrail, IAM roles, VPC networking, and AWS Single Sign-On (SSO).

## Features
- **AWS Organizations**: Creates and manages AWS Organizational Units (OUs).
- **AWS Config**: Enables AWS Config with predefined rules for compliance.
- **AWS CloudTrail**: Centralizes logging for AWS account activities.
- **IAM Roles**: Creates predefined IAM roles with specified permissions.
- **AWS Single Sign-On (SSO)**: Manages access control across multiple AWS accounts.
- **Networking**: Configures VPC, subnets, and security groups.
- **Security Services**: Enables AWS GuardDuty, Security Hub, AWS Shield, and AWS WAF.

## Folder Structure
```
├── modules/
│   ├── aws_landing_zone/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── README.md
```

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) v1.0.0+
- AWS account with necessary permissions
- AWS CLI configured with valid credentials

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/your-repo/aws-landing-zone-terraform.git
   cd aws-landing-zone-terraform
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Review execution plan:
   ```sh
   terraform plan
   ```
4. Apply the configuration:
   ```sh
   terraform apply
   ```

## Usage
Include this module in your Terraform configuration:

```hcl
module "aws_landing_zone" {
  source = "./modules/aws_landing_zone"

  enable_aws_organization  = true
  organization_units       = ["Security", "Infrastructure", "Development", "Production"]
  enable_aws_config        = true
  aws_config_recorder_name = "default"
  aws_config_delivery_bucket = "landing-zone-config-bucket"
  enable_aws_cloudtrail    = true
  aws_cloudtrail_name      = "landing-zone-trail"
  aws_cloudtrail_bucket_name = "landing-zone-cloudtrail-bucket"
  enable_iam_roles         = true
  enable_aws_sso           = true
  aws_sso_users            = ["admin@company.com", "devops@company.com"]
}
```

## Outputs
After successful deployment, Terraform provides the following outputs:

| Output                  | Description                                      |
|-------------------------|--------------------------------------------------|
| `aws_organization_id`   | AWS Organization ID                             |
| `aws_cloudtrail_id`     | CloudTrail ID                                   |
| `aws_config_recorder`   | AWS Config Recorder Name                        |

## Cleanup
To remove all resources created by this module, run:
```sh
terraform destroy
```

## License
This project is licensed under the MIT License.

## Support
For issues or feature requests, please open an issue in the repository.
