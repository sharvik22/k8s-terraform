# Токен для доступа к Yandex Cloud
variable "yc_token" {
  type      = string
  sensitive = true # Помечаем как чувствительную переменную
}

# ID облака
variable "cloud_id" {
  type        = string
  default     = "b1g811k1u7vur9c50o56"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

# ID каталога
variable "folder_id" {
  type        = string
  default     = "b1guevbvpqmirfgfolig"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

# Зона по умолчанию
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# Имя VPC
variable "VPC_name" {
  type    = string
  default = "my-vpc"
}

# Базовое имя для публичных подсетей
variable "public_subnet_name" {
  type    = string
  default = "public"
}

# CIDR-блок для публичных подсетей
variable "public_v4_cidr_blocks" {
  type    = list(string)
  default = ["192.168.10.0/24"]
}

# Список зон доступности для публичных подсетей
variable "public_subnet_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}
