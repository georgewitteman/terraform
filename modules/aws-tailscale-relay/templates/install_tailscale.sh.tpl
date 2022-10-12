#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o xtrace

curl --fail --silent --show-error --location "https://tailscale.com/install.sh" | sh -s --

export DEBIAN_FRONTEND=noninteractive

authkey=$(aws secretsmanager get-secret-value --secret-id ${secrets_manager_arn} --region ${region} --output text --query SecretString)

sudo systemctl enable --now tailscaled
sudo tailscale up "--authkey=$authkey" "--advertise-routes=${cidr}"
