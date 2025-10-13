data "aws_route53_zone" "bcrowthe" {
  name         = "bcrowthe.com"
  private_zone = false
}


data "aws_route53_zone" "jcrowthe" {
  name         = "jcrowthe.ca"
  private_zone = false
}
