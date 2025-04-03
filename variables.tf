# Токен для доступа к Yandex Cloud
variable "yc_token" {
  type        = string
  sensitive   = true
  description = "OAuth-токен или IAM-токен для аутентификации в Yandex Cloud"
}

# Публичный SSH-ключ для доступа к ВМ
variable "ssh_public_key" {
  type        = string
  sensitive   = true
  description = "SSH public key для доступа к виртуальным машинам в формате 'ssh-rsa AAA...'"
}

# ID облака
variable "cloud_id" {
  type        = string
  default     = "b1g811k1u7vur9c50o56"
  description = "Идентификатор облака в Yandex Cloud"
}

# ID каталога
variable "folder_id" {
  type        = string
  default     = "b1guevbvpqmirfgfolig"
  description = "Идентификатор каталога в Yandex Cloud"
}

# Зона по умолчанию
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Зона доступности по умолчанию"
}

# Имя VPC сети
variable "VPC_name" {
  type        = string
  default     = "k8s-vpc"
  description = "Имя создаваемой VPC сети"
}

# Базовое имя для публичных подсетей
variable "public_subnet_name" {
  type        = string
  default     = "public"
  description = "Базовое имя для публичных подсетей"
}

# CIDR-блок для публичных подсетей
variable "public_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "CIDR-блок для публичных подсетей"
}

# Список зон доступности для публичных подсетей
variable "public_subnet_zones" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b"]
  description = "Список зон доступности для создания подсетей"
}

# ID образа для виртуальных машин
variable "vm_image_id" {
  type        = string
  default     = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04 LTS
  description = "ID образа для виртуальных машин"
}

# Размер диска для виртуальных машин (ГБ)
variable "vm_disk_size" {
  type        = number
  default     = 20
  description = "Размер загрузочного диска виртуальных машин в ГБ"
}

# Конфигурация master-ноды
variable "master_node" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
  description = "Конфигурация ресурсов для master-ноды"
}

# Конфигурация worker-нод
variable "worker_nodes" {
  type = object({
    count         = number
    cores         = number
    memory        = number
    core_fraction = number
    preemptible   = bool
  })
  default = {
    count         = 2
    cores         = 2
    memory        = 4
    core_fraction = 5
    preemptible   = true
  }
  description = "Конфигурация ресурсов для worker-нод"
}

# Настройки балансировщика нагрузки
variable "load_balancer" {
  type = object({
    name        = string
    region_id   = string
    target_port = number
    healthcheck = object({
      path = string
      port = number
    })
  })
  default = {
    name        = "k8s-load-balancer"
    region_id   = "ru-central1"
    target_port = 80
    healthcheck = {
      path = "/healthz"
      port = 80
    }
  }
  description = "Настройки балансировщика нагрузки"
}

# Настройки групп безопасности
variable "security_groups" {
  type = object({
    name        = string
    description = string
  })
  default = {
    name        = "k8s-security-group"
    description = "Security group for Kubernetes cluster"
  }
  description = "Настройки групп безопасности"
}
