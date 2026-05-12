# Общие параметры ВМ
variable "vm_name" {
  type = string
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 4
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "disk_type" {
  type    = string
  default = "network-ssd"
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "labels" {
  type = map(string)
  default = {
    env = "dev"
  }
}

# Инфраструктурные переменные
variable "subnet_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}
