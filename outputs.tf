output "ip address" {
  value = "${digitalocean_droplet.nfs-server.ipv4_address}"
}

output "mount point" {
  value = "${var.mount_point}"
}
