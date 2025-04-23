terraform {
  required_version = ">= 1.11"  # Ensure Terraform is recent enough

  required_providers {
    google = {
      source  = "hashicorp/google"  # Use the official Google provider
      version = "~> 5.0"            # Compatible with Terraform 1.x
    }
  }

  backend "local" {}  # Store Terraform state locally (for now; can be switched to GCS later)
}

provider "google" {
  project = var.project_id  # Use the project ID from variables.tf
  region  = var.region      # Use the region from variables.tf
}

