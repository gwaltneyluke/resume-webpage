provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "gwaltney-terraform-states"
    key    = "gwaltney-resume.tfstate"
    region = "us-east-1"
  }
}

###### locals

locals {
  bucket_name = "www.gwaltney-resume.com"
}

###### resources

resource "aws_s3_bucket" "gwaltney_resume" {
  bucket = local.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "resume_html" {
  bucket              = local.bucket_name
  key                 = "index.html"
  source              = "../public/index.html"
  etag                = filemd5("../public/index.html")
  acl                 = "public-read"
  content_type        = "text/html"
  content_disposition = "inline"
}

resource "aws_s3_bucket_object" "error_html" {
  bucket = local.bucket_name
  key    = "error.html"
  source = "../public/error.html"
  etag   = filemd5("../public/error.html")
  acl    = "public-read"

  content_type        = "text/html"
  content_disposition = "inline"
}

resource "aws_s3_bucket_object" "resume_css" {
  bucket = local.bucket_name
  key    = "index.css"
  source = "../public/index.css"
  etag   = filemd5("../public/index.css")
  acl    = "public-read"

  content_type        = "text/css"
  content_disposition = "inline"
}