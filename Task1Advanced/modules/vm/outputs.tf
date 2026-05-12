output "instance_id" {
  description = "ID созданной ВМ"
  value       = yandex_compute_instance.vm.id
}

output "instance_name" {
  description = "Имя ВМ"
  value       = yandex_compute_instance.vm.name
}

output "internal_ip" {
  description = "Внутренний IP ВМ"
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "external_ip" {
  description = "Внешний IP ВМ"
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "disk_id" {
  description = "ID загрузочного диска"
  value       = yandex_compute_instance.vm.boot_disk.0.disk_id
}
