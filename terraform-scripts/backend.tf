terraform {

  backend "s3" {
    region  = "us-east-2"
    bucket  = "544406947890-terraform-state-storage"
    key     = "service/ansible/terraform.tfstate"
  }
}

provider "aws" {
  region  = "${var.aws_region}"
}