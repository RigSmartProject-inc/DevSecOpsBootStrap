terraform {
  required_version = "~> 1.0"
  backend "s3" {
    bucket = "infrabucket-awssreactions-ca-central-1"
    key    = "aws-sre-actions/state.tfstate"
    region = "ca-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.16"
    }
  }
}