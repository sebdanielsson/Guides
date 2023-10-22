# Proxmox

## SSH

Add your SSH public key to `~/.ssh/authorized_keys`.

## Update system

### Enable pve-no-subscription repo

`/etc/apt/sources.list`

```sh
# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
```

### Disable pve-subscription enterprise repo

`/etc/apt/sources.list.d/pve-enterprise.list`

Comment out repo.

### Upgrade system

```sh
apt dist-upgrade
```

## Install software

```sh
curl -fsSL https://tailscale.com/install.sh | sh
apt install tmux
```

## Enable IOMMU

`/etc/default/grub`

```ini
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
```

```sh
update-grub
```

`/etc/modules`

```ini
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

```sh
reboot
```

## NFS Share of zfs-pool

```sh
apt install nfs-kernel-server

zfs set sharenfs=crossmnt,no_root_squash,rw=192.168.1.0/24 chungus/media

chown nobody:nogroup /chungus/media
chmod 666 /chungus/media
```
