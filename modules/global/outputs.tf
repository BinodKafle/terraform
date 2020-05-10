// For global output that are not region specific
output "out_vpc_self_link" {
  value = "${google_compute_network.vpc.self_link}"
}