#############################
# Создание VPC
resource "yandex_vpc_network" "my_vpc" {
  name = var.VPC_name
}

# Создание публичных подсетей
resource "yandex_vpc_subnet" "public_subnet" {
  count = length(var.public_subnet_zones)                                     # Количество подсетей равно количеству зон
  name  = "${var.public_subnet_name}-${var.public_subnet_zones[count.index]}" # Имя подсети
  v4_cidr_blocks = [
    cidrsubnet(var.public_v4_cidr_blocks[0], 4, count.index) # Разделение CIDR-блока на подсети
  ]
  zone       = var.public_subnet_zones[count.index] # Зона доступности
  network_id = yandex_vpc_network.my_vpc.id         # Привязка к созданной VPC
}
