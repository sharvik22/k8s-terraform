terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.84.0"
    }
  }
  required_version = ">= 0.84.0"
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
#  service_account_key_file = file("~/.authorized_key.json")  # Указание файла ключа сервисного аккаунта
  service_account_key_file = file("/home/admon/diplom/k8s/authorized_key.json")
}
