#!/bin/bash
set -e

exec > >(tee /var/log/langflow-setup.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update and install system dependencies
apt update
apt install -y python3 python3-pip python3-venv build-essential python3-dev

# Install uv (fast Python installer)
python3 -m pip install --upgrade pip
pip install uv

# Create application directory
INSTALL_DIR="/opt/langflow"
mkdir -p "$INSTALL_DIR"
chown ubuntu:ubuntu "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Set up Python virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Upgrade pip in venv and install Langflow with uv
pip install --upgrade pip
uv pip install langflow

# Start Langflow in the background and log output
nohup "$INSTALL_DIR/.venv/bin/langflow" run > /var/log/langflow.log 2>&1 &

echo "Langflow installation complete. Access it on port 7860."
