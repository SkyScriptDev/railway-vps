#!/bin/bash
set -e

ROOT_PASSWORD="Root@123456"

mkdir -p /var/run/sshd

# Generate SSH host keys
ssh-keygen -A

# Set root password
echo "root:${ROOT_PASSWORD}" | chpasswd

# Configure SSH
cat > /etc/ssh/sshd_config.d/railway.conf <<EOF
Port 22
ListenAddress 0.0.0.0

PermitRootLogin yes
PasswordAuthentication yes
PubkeyAuthentication yes

UsePAM yes
X11Forwarding no
AllowTcpForwarding yes
GatewayPorts no
EOF

# Validate SSH configuration
/usr/sbin/sshd -t

echo "========================================"
echo "Ubuntu SSH Server"
echo "========================================"
echo "User: root"
echo "Port: 22"
echo "SSH server is starting..."
echo "========================================"

exec /usr/sbin/sshd -D -e
