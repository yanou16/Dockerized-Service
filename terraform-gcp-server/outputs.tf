output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "L'adresse IP externe de l'instance"
}

output "instance_name" {
  value = google_compute_instance.vm_instance.name
  description = "Le nom de l'instance"
}