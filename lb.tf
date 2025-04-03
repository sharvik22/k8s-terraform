# lb.tf
resource "yandex_lb_target_group" "k8s_nodes" {
  name      = "k8s-nodes-target-group"
  region_id = "ru-central1" # Важно указать регион, а не зону

  # Мастер-нода
  target {
    subnet_id = yandex_vpc_subnet.public_subnet[0].id # ru-central1-a
    address   = yandex_compute_instance.k8s_master.network_interface.0.ip_address
  }

  # Воркер-ноды
  dynamic "target" {
    for_each = yandex_compute_instance.k8s_worker
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "k8s_lb" {
  name = "k8s-load-balancer"
  type = "external"

  listener {
    name = "http"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  listener {
    name = "https"
    port = 443
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.k8s_nodes.id

    healthcheck {
      name                = "http-healthcheck"
      interval            = 2
      timeout             = 1
      unhealthy_threshold = 3
      healthy_threshold   = 3
      http_options {
        port = 80
        path = "/healthz"
      }
    }
  }
}
