terraform {
  required_providers {
    aws = {
        sourcee = "hashicorp/aws"
        version = "~> 4.33.0"
    }    
  }
}

provider "aws" {
    region = "us-east-1"
    alias  = "us"
}