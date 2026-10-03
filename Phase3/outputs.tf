output "bucket_name" {
  description = "Name of the E-Commerce product assets bucket"
  value       = aws_s3_bucket.product_assets.bucket
}
output "bucket_arn" {
  description = "ARN of the E-Commerce product assets bucket"
  value       = aws_s3_bucket.product_assets.arn
}
output "current_region" {
  description = "AWS region detected by the Terraform AWS provider"
  value       = data.aws_region.current.region
  # value       = data.aws_region.current.name
}
output "selected_vpc_id" {
  value = data.aws_vpc.selected.id
}