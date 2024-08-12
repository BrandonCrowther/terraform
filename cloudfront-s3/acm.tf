provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

resource "aws_acm_certificate" "this" {
  domain_name               = var.site_domain
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.site_domain}"]
  provider                  = aws.us-east-1
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider        = aws.us-east-1
  certificate_arn = aws_acm_certificate.this.id
}
