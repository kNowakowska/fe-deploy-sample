# Unikalna nazwa bucketu jest wymagana do utworzenia zasobu S3
resource "aws_s3_bucket" "ofe_bucket" {
  bucket = "ofe-rmcatalog-b4465722-2ab3-457f-8dc1-a1d714619278"
}

resource "aws_s3_bucket_ownership_controls" "ofe_bucket_ownership" {
  bucket = aws_s3_bucket.ofe_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "ofe_bucket_access" {
  bucket = aws_s3_bucket.ofe_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "ofe_cloudfront_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ofe_bucket_ownership,
    aws_s3_bucket_public_access_block.ofe_bucket_access,
  ]

  bucket = aws_s3_bucket.ofe_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "ofe_bucket_policy" {
  bucket = aws_s3_bucket.ofe_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::ofe-rmcatalog-b4465722-2ab3-457f-8dc1-a1d714619278/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "example_website_configuration" {
  bucket = aws_s3_bucket.ofe_bucket.id

  index_document {
    suffix = "index.html"
  }
}
