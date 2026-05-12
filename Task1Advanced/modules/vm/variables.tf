# Virtual machine variables

variable "vm_name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "cores" {
  description = "Количество ядер CPU"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Объём RAM в ГБ"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Размер подключаемого диска в ГБ"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Тип диска (network-hdd, network-ssd, local-ssd)"
  type        = string
  default     = "network-ssd"
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "image_family" {
  description = "Семейство образа ОС (например, ubuntu-2004-lts)"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "environment" {
  description = "Окружение (dev, stage, prod)"
  type        = string
}

variable "labels" {
  description = "Метки для ресурсов"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "ID подсети, к которой подключается ВМ"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH-ключ для доступа к ВМ"
  type        = string
}
