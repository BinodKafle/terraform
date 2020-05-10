output "uc1_pri_address" {
  value = "${google_compute_subnetwork.private_subnet.self_link}"
}

output "uc1_pub_address" {
  value = "${google_compute_subnetwork.public_subnet.self_link}"
}