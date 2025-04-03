#!/bin/bash

# Получаем JSON-вывод Terraform
TF_JSON=$(terraform output -json all_ips)

# Извлекаем значения с помощью jq
export MASTER_PUBLIC_IP=$(echo "$TF_JSON" | jq -r '.master_public_ip')
export MASTER_PRIVATE_IP=$(echo "$TF_JSON" | jq -r '.master_private_ip')

# Worker 1
export WORKER1_PUBLIC_IP=$(echo "$TF_JSON" | jq -r '.workers_public.worker_1')
export WORKER1_PRIVATE_IP=$(echo "$TF_JSON" | jq -r '.workers_private.worker_1')

# Worker 2
export WORKER2_PUBLIC_IP=$(echo "$TF_JSON" | jq -r '.workers_public.worker_2')
export WORKER2_PRIVATE_IP=$(echo "$TF_JSON" | jq -r '.workers_private.worker_2')

# Выводим переменные для проверки
echo "Master Public IP: $MASTER_PUBLIC_IP"
echo "Master Private IP: $MASTER_PRIVATE_IP"
echo "Worker1 Public IP: $WORKER1_PUBLIC_IP"
echo "Worker1 Private IP: $WORKER1_PRIVATE_IP"
echo "Worker2 Public IP: $WORKER2_PUBLIC_IP"
echo "Worker2 Private IP: $WORKER2_PRIVATE_IP"
