# Show the cluster name after creation
output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}

# Show the API endpoint (public IP) of the cluster
output "kubernetes_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

