# Основные переменные для провайдера
variable "yc_token" {
  type        = string
  sensitive   = true
  description = "Yandex Cloud OAuth token"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "default_zone" {
  type        = string
  description = "Default availability zone"
}

# Переменные для VPC
variable "VPC_name" {
  type        = string
  default     = "k8s-vpc"
  description = "VPC network name"
}

variable "public_subnet_name" {
  type        = string
  default     = "public"
  description = "Public subnet name prefix"
}

variable "public_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "Public subnet CIDR blocks"
}

variable "public_subnet_zones" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  description = "Availability zones for public subnets"
}

# SSH ключ
variable "ssh_public_key" {
  type        = string
  sensitive   = true
  description = "SSH public key for VM access"
}
