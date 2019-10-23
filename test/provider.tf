provider "aws" {
  
}
terraform {
  backend "s3" {
    bucket = "lakshmaiahaws.xyz"
    key    = "JENKINSPROJECT/TEST/terraform.tfstate"
    region = "us-east-1"
  }
}