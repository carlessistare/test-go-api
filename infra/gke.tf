# Create a GKE Autopilot cluster in the specified region
resource "google_container_cluster" "primary" {
  name     = var.cluster_name         # from variables.tf
  location = var.region               # e.g. europe-north1

  enable_autopilot = true             # << Autopilot mode enabled

  networking_mode = "VPC_NATIVE"      # Use IP aliasing (required)
  ip_allocation_policy {}             # Auto-assign subnet ranges

  release_channel {
    channel = "REGULAR"               # Choose between RAPID | REGULAR | STABLE
  }

  # Optional: default to private nodes and public control plane
  # You can uncomment this later for private clusters
  # private_cluster_config {
  #   enable_private_nodes = true
  #   enable_private_endpoint = false
  # }
}

