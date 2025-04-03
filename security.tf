resource "yandex_vpc_security_group" "k8s_security_group" {
  name        = "k8s-security-group"
  description = "Security group for Kubernetes cluster"
  network_id  = yandex_vpc_network.my_vpc.id

  # Полное разрешение всего трафика между нодами кластера
  ingress {
    protocol       = "ANY"
    description    = "Full internal cluster communication"
    v4_cidr_blocks = ["192.168.10.0/24"]  # Весь диапазон подсети
    from_port      = 0
    to_port        = 65535
  }

  # Критически важные порты для Kubernetes
  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API server"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    description    = "etcd client API"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 2379
  }

  ingress {
    protocol       = "TCP"
    description    = "etcd peer API"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 2380
  }

  ingress {
    protocol       = "TCP"
    description    = "Kubelet API"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 10250
  }

  # Внешние порты
  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  # NodePort диапазон
  ingress {
    protocol       = "TCP"
    description    = "NodePort range"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }

  # Разрешить весь исходящий трафик
  egress {
    protocol       = "ANY"
    description    = "Outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
