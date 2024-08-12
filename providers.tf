terraform {
  backend "s3" {
    region = "ca-central-1"
    bucket = "bcrowthe-tfstate"
    key    = "all.tfstate"
  }
}

provider "aws" {
  region = "ca-central-1"
  default_tags {
    tags = {
      Terraform = "true"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}
