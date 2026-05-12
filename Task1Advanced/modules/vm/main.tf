terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "yandex_compute_disk" "vm_disk" {
  name     = "${var.vm_name}-disk-${random_id.suffix.hex}"
  type     = var.disk_type
  zone     = var.zone
  image_id = data.yandex_compute_image.ubuntu.image_id
  size     = var.disk_size
}

resource "yandex_compute_instance" "vm" {
  name = "${var.vm_name}-${substr(uuid(), 0, 8)}"
  zone = var.zone

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.vm_disk.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }

  # Прерываемые ВМ — дешевле, подходят для dev/stage
  scheduling_policy {
    preemptible = var.environment == "dev" || var.environment == "stage" ? true : false
  }

  lifecycle {
    create_before_destroy = true
  }
}
