#!/bin/sh
sudo hostnamectl set-hostname mediaserver
sudo timedatectl set-timezone Europe/Stockholm

# upgrade system
dnf -q -y upgrade
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf config-manager --add-repo https://pkg.cloudflare.com/cloudflared-ascii.repo
sudo dnf -y install dnf-automatic dnf-plugin-system-upgrade cockpit-pcp dnf-automatic docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-scan-plugin wireguard-tools bind git restic tailscale tmux python3-pip cloudflared nfs-utils

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable --now docker

# SELinux in permissive mode until Tailscale #4908 is fixed.
sudo systemctl enable --now tailscaled
sudo sed -i 's/SELINUX=enforcing.*/SELINUX=permissive/' /etc/selinux/config
sudo tailscale up --ssh --authkey='<super-secret-auth-key>'

sudo reboot
