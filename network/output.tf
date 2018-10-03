output network_name {
    description = "The network name"
    value       = "${google_compute_network.gocron.name}"
}

output subnetwork_name {
    description = "The subnetwork name"
    value       = "${google_compute_subnetwork.gocron.name}"
}
