variable "yc_token" {
  type        = string
  sensitive   = true
  description = "Yandex Cloud OAuth token"
}

variable "cloud_id" {
  type        = string
  default     = "b1g811k1u7vur9c50o56"
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  default     = "b1guevbvpqmirfgfolig"
  description = "Yandex Cloud Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default availability zone"
}

variable "VPC_name" {
  type        = string
  default     = "my-vpc"
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

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
  sensitive   = true
}
