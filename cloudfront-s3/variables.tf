variable "root_zone" {
  type = string
}

variable "site_domain" {
  type = string
}

variable "site_entrypoint" {
  type    = string
  default = "index.html"
}

variable "upload_path" {
  type = string
}


provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
