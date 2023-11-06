#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Define the Node Exporter version to install (you can change this)
NODE_EXPORTER_VERSION="1.6.1"

# Define the download URL for Node Exporter
DOWNLOAD_URL="https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz"

# Define the directory to install Node Exporter
INSTALL_DIR="/usr/local/bin"

# Create a user for Node Exporter (optional but recommended)
useradd -rs /bin/false node_exporter

# Download and install Node Exporter
curl -LO $DOWNLOAD_URL
tar -xvf "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
cp "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter" "$INSTALL_DIR/"

# Set permissions and ownership
chown node_exporter:node_exporter "$INSTALL_DIR/node_exporter"

# Create a systemd service for Node Exporter
cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=$INSTALL_DIR/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Node Exporter
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter

echo "Node Exporter has been installed and started."
