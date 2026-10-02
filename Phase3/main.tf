resource "aws_s3_bucket" "product_assets" {
  bucket = local.bucket_name
  tags = {
    Environment = "dev"
    Purpose     = "product-assets"
  }
}