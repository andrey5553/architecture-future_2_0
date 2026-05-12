terraform {
  backend "s3" {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "mihailenko.a1-backet"
    region     = "ru-central1"
    key        = "prod/vm.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
