# # 1. Terraform Block
# terraform {
#   required_providers {
#     aws = {
#         source = "hashicorp/aws"
#         version = "~> 6.0"
#     }
#   }
# }

# # 2. Provider Configuration
# provider "aws" {
#   region = "ap-south-1"
# }

# # 3. Resource Configuration
# resource "aws_s3_bucket" "product_assets" {
#     bucket = "ecommerce-dev-product-assets-milan"

# }

# 1. Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# 2. Provider Configuration
provider "aws" {
  region = var.aws_region
}

# 3. Resource Configuration
resource "random_id" "bucket_suffix" {
  byte_length = 4
}
resource "aws_s3_bucket" "product_assets" {
  bucket = "${var.project_name}-${var.environment}-product-assets-milan-58ebfbb7"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Environment = var.environment
    Purpose     = "product-assets"
  }
}
resource "aws_s3_bucket" "product_assets_new_policy" {
  bucket = "${var.project_name}-${var.environment}-product-assets-milan-${random_id.bucket_suffix.hex}"
#   lifecycle {
#     prevent_destroy = true
#   }
  tags = {
    Environment = var.environment
    Purpose     = "product-assets_new_policy"
  }

}
resource "aws_iam_policy" "product_assets_access" {
  name = "${var.project_name}-${var.environment}-product-assets-access"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = "${aws_s3_bucket.product_assets.arn}/*"
      }
    ]
  })

  tags = {
    Environment = var.environment
    Purpose     = "product-assets-access"
  }
}