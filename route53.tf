data "aws_route53_zone" "bcrowthe" {
  name         = "bcrowthe.com"
  private_zone = false
}


data "aws_route53_zone" "jcrowthe" {
  name         = "jcrowthe.ca"
  private_zone = false
}

resource "aws_route53_record" "wildcard_bcrowthe" {
  zone_id = data.aws_route53_zone.bcrowthe.zone_id
  name    = "*.bcrowthe.com"
  type    = "A"
  ttl     = 300
  records = ["47.55.79.68"]
}
