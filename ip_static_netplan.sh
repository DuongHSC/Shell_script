#!/bin/bash

# Check if script is run with sudo/root privileges

# Prompt user for network configuration details
read -p "Enter the hostname: " hostnames
read -p "Enter the network interface name (e.g., eth0): " interface
read -p "Enter the static IP address (e.g., 192.168.1.100/24): " ip_address
read -p "Enter the gateway IP address (e.g., 192.168.1.1): " gateway
read -p "Enter the primary DNS server IP address (e.g., 8.8.8.8): " dns_primary
read -p "Enter the secondary DNS server IP address (e.g., 8.8.4.4): " dns_secondary

hostnamectl set-hostname $hostnames

# Generate the Netplan configuration file with user input
cat > /etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $interface:
      dhcp4: no
      addresses: [$ip_address]
      gateway4: $gateway
      nameservers:
        addresses: [$dns_primary, $dns_secondary]
EOF

# Apply the new Netplan configuration
netplan apply

echo "Static IP configuration applied successfully!"
