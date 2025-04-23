# Google Cloud project ID — must match the project you created
variable "project_id" {
  description = "Your GCP project ID"
  type        = string
  default     = "hello-geoip-service"  # Change if your project ID is different
}

# GCP region where the resources will be deployed
variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-north1"  # You can change to any supported GKE region
}

# Name of the GKE (Google Kubernetes Engine) cluster
variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "geoip-cluster"
}

