
module "resume_site" {
  source          = "./cloudfront-s3"
  site_domain     = "resume.bcrowthe.com"
  root_zone       = "bcrowthe.com"
  upload_path     = "../resume/build"
  site_entrypoint = "resume.pdf"
}

module "blog_site" {
  source      = "./cloudfront-s3"
  site_domain = "blog.bcrowthe.com"
  root_zone   = "bcrowthe.com"
  upload_path = "../blog/build"
}
