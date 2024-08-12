resource "aws_s3_bucket" "this" {
  bucket = "${var.site_domain}-s3-website-bucket"
}

resource "aws_s3_bucket_website_configuration" "website_bucket" {
  bucket = aws_s3_bucket.this.id
  index_document {
    suffix = var.site_entrypoint
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "public-read"
}

# TODO: Restrict to only CF
resource "aws_s3_bucket_policy" "bucket_public_read" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.this.bucket}/*"
      }
    ]
  })
}

resource "aws_s3_object" "site_objects" {
  for_each = module.template_files.files
  bucket   = aws_s3_bucket.this.id

  key          = each.key
  source       = each.value.source_path
  content      = each.value.content
  content_type = each.value.content_type

  etag = each.value.digests.md5
}
