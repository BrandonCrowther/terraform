resource "aws_s3_bucket" "this" {
  bucket = "${local.domain}-s3-website-bucket"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    condition {
      variable = "aws:SourceArn"
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.bucket
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
    depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this,
  ]
  acl = "public-read"
}

resource "aws_s3_object" "root" {
    bucket = aws_s3_bucket.this.id
    key = "index.html"
    source = "../resume/resume.html"
    acl = "public-read"
    content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website_bucket" {
  bucket = aws_s3_bucket.this.id
  index_document {
    suffix = "index.html"
  }
}