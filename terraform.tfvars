enable_aws_organization = true
organization_units      = ["Security", "Infrastructure", "Development", "Production"]

enable_aws_config        = true
aws_config_recorder_name = "default"
aws_config_delivery_bucket = "landing-zone-config-bucket"

enable_aws_cloudtrail    = true
aws_cloudtrail_name      = "landing-zone-trail"
aws_cloudtrail_bucket_name = "landing-zone-cloudtrail-bucket"

enable_iam_roles = true

enable_aws_sso  = true
aws_sso_users   = ["admin@company.com", "devops@company.com"]

vpc_cidr       = "10.0.0.0/16"
enable_vpc     = true
enable_subnets = true
enable_sg      = true
