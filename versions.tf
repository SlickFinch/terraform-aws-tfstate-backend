terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.1"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}
