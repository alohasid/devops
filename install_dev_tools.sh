#!/bin/bash

set -euo pipefail

if ! command -v docker &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
else
    echo "Docker вже встановлено."
fi

if ! docker compose version &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y docker-compose-plugin
else
    echo "Docker Compose V2 вже встановлено."
fi

PYTHON_VALID=0
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    REQUIRED_VERSION="3.9"
    if [ "$(echo -e "$PYTHON_VERSION\n$REQUIRED_VERSION" | sort -V | head -n1)" = "$REQUIRED_VERSION" ]; then
        PYTHON_VALID=1
    fi
fi

if [ "$PYTHON_VALID" -eq 0 ]; then
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
else
    echo "Python 3 (>= 3.9) вже встановлено."
fi

if ! python3 -m django --version &> /dev/null; then
    pip3 install django --break-system-packages
else
    echo "Django вже встановлено."
fi