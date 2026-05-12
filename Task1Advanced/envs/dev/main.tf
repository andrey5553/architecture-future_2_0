terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.202.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
  required_version = ">= 0.13"
}

module "mihailenko-a1-task1-dev" {
  source = "../../modules/vm"

  environment    = var.environment
  vm_name        = var.vm_name
  cores          = var.cores
  memory         = var.memory
  disk_size      = var.disk_size
  disk_type      = var.disk_type
  zone           = var.zone
  image_family   = var.image_family
  subnet_id      = var.subnet_id
  ssh_public_key = var.ssh_public_key
  labels         = var.labels
}