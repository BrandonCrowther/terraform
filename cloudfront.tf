
locals {
  domain = "test.bcrowthe.com"
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    origin_id   = local.domain
    domain_name = aws_s3_bucket.this.bucket_regional_domain_name
  }

  aliases = [local.domain, "www.${local.domain}"]
  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.domain

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.this.arn
    ssl_support_method = "sni-only"
  }
}