output "aws_organization_id" {
  value = aws_organizations_organization.org[0].id
}

output "aws_cloudtrail_id" {
  value = aws_cloudtrail.trail[0].id
}

output "aws_config_recorder" {
  value = aws_s3_bucket.config_bucket[0].id
}

output "iam_admin_role" {
  value = aws_iam_role.admin_role.arn
}

output "iam_read_only_role" {
  value = aws_iam_role.read_only_role.arn
}

output "vpc_id" {
  value = aws_vpc.main.id
}
