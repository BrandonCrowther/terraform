data "aws_route53_zone" "this" {
  name         = "bcrowthe.com"
  private_zone = false
}
