data "aws_route53_zone" "this" {
  name         = "bcrowthe.com"
  private_zone = false
}

resource "aws_route53_record" "validation" {
    for_each = {
        for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this.zone_id
}


resource "aws_route53_record" "this" {
    name = local.domain
    type = "A"
    zone_id = data.aws_route53_zone.this.id

    alias {
        name = aws_cloudfront_distribution.this.domain_name
        zone_id = aws_cloudfront_distribution.this.hosted_zone_id
        evaluate_target_health = true
    }
}