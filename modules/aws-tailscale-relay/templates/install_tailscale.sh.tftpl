#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o xtrace

curl --fail --silent --show-error --location "https://tailscale.com/install.sh" | sh -s --

export DEBIAN_FRONTEND=noninteractive

authkey=$(aws secretsmanager get-secret-value --secret-id ${secrets_manager_arn} --region ${region} --output text --query SecretString)

# https://tailscale.com/kb/1019/subnets/?tab=linux#enable-ip-forwarding
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

sudo systemctl enable --now tailscaled
sudo tailscale up "--authkey=$authkey" "--advertise-routes=${cidr}"
