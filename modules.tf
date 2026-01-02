
module "resume_site" {
  source          = "./cloudfront-s3"
  site_domain     = "resume.bcrowthe.com"
  root_zone       = "bcrowthe.com"
  upload_path     = "../resume/build"
  site_entrypoint = "resume.pdf"
}

#
# module "blog_site" {
#   source      = "./cloudfront-s3"
#   site_domain = "blog.bcrowthe.com"
#   root_zone   = "bcrowthe.com"
#   upload_path = "../blog/build"
# }


module "snake_site" {
  source      = "./cloudfront-s3"
  site_domain = "snake.bcrowthe.com"
  root_zone   = "bcrowthe.com"
  upload_path = "../SnakeNN/web/build"
}


# Justin's site(s)

module "justin_lawn_site" {
  source          = "./cloudfront-s3"
  site_domain     = "lawn.jcrowthe.ca"
  root_zone       = "jcrowthe.ca"
  upload_path     = "../justin"
  site_entrypoint = "website.pdf"
}


module "justin_lawn_site2" {
  source          = "./cloudfront-s3"
  site_domain     = "tmp.jcrowthe.ca"
  root_zone       = "jcrowthe.ca"
  upload_path     = "../justin2/build/client"
  site_entrypoint = "index.html"
}
