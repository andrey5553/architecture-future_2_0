terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "mihailenko.a1-backet"
    region     = "ru-central1"
    key        = "dev/vm.tfstate"
    
    # Обязательные параметры для Yandex S3
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    
    use_path_style              = true
    # disable_compute_service_status = true
  }
}