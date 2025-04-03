############################################
# Создание виртуальной машины для master-ноды
resource "yandex_compute_instance" "k8s_master" {
  name        = "k8s-master"
  platform_id = "standard-v2"
  zone        = var.public_subnet_zones[0]  # Используем первую зону из списка

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk"
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public_subnet[0].id  # Подсеть из той же зоны
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s_security_group.id]
  }

  metadata = {
    ssh-keys  = "ubuntu:${var.ssh_public_key}"
    user-data = <<-EOF
      #cloud-config
      timezone: Europe/Moscow
      users:
        - name: ubuntu
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh-authorized-keys:
            - ${var.ssh_public_key}
      EOF
  }

  service_account_id = "aje5egcnh4t73raucnli"
}

# Создание виртуальных машин для worker-нод
resource "yandex_compute_instance" "k8s_worker" {
  count       = 2
  name        = "k8s-worker-${count.index + 1}"
  platform_id = "standard-v2"
  zone        = var.public_subnet_zones[count.index]  # Используем соответствующую зону

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }

  scheduling_policy {
    preemptible = true  # Для всех worker-нод
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk"
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public_subnet[count.index].id  # Подсеть из той же зоны
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s_security_group.id]
  }

  metadata = {
    ssh-keys  = "ubuntu:${var.ssh_public_key}"
    user-data = <<-EOF
      #cloud-config
      timezone: Europe/Moscow
      users:
        - name: ubuntu
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh-authorized-keys:
            - ${var.ssh_public_key}
      EOF
  }

  service_account_id = "aje5egcnh4t73raucnli"
}
