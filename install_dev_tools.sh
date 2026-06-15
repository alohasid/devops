#!/bin/bash

# Перевірка на права суперкористувача (root)
if [ "$EUID" -ne 0 ]; then
  echo "Будь ласка, запустіть скрипт з правами sudo."
  exit 1
fi

echo "Починаємо встановлення інструментів..."

# 1. Встановлення Docker
if ! command -v docker &> /dev/null; then
    echo "Встановлення Docker..."
    apt-get update
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
else
    echo "Docker вже встановлено."
fi

# 2. Встановлення Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "Встановлення Docker Compose..."
    apt-get install -y docker-compose
else
    echo "Docker Compose вже встановлено."
fi

# 3. Встановлення Python 3 та pip
if ! command -v python3 &> /dev/null; then
    echo "Встановлення Python 3..."
    apt-get install -y python3 python3-pip
else
    echo "Python 3 вже встановлено."
fi

# 4. Встановлення Django
if ! python3 -m django --version &> /dev/null; then
    echo "Встановлення Django..."
    pip3 install django --break-system-packages
else
    echo "Django вже встановлено."
fi

echo "Всі інструменти успішно перевірені або встановлені!"