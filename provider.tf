terraform {
  backend "s3" {
    bucket = "franky-iac-bucket"
    key    = "terraform/states/terraform.tfstate"
    region = "eu-west-3"
  }
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "kubernetes-admin@kubernetes"
}
