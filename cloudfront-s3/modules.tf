# S3 needs the content_type and I don't want to write my own code to retrieve it
module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = var.upload_path
}
