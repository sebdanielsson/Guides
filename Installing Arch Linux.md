# Arch Linux Installation & Linux Guides

[Installation guide - ArchWiki](https://wiki.archlinux.org/index.php/Installation_guide)

## Pre Installation

#### Configure keyboard keymaps
In my case, a swedish keyboard.
```
loadkeys sv-latin1
```
[Keyboard configuration](https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration#Loadkeys), [loadkeys(1)](https://man.archlinux.org/man/loadkeys.1)

#### Configure mirrors
Edit `/etc/pacman.d/mirrorlist` and uncomment a couple of nearby mirrors

[Mirrors](https://wiki.archlinux.org/index.php/Mirrors)

#### Update the system clock
```
timedatectl set-ntp true
```
[System time](https://wiki.archlinux.org/index.php/System_time), [timedatectl(1)](https://man.archlinux.org/man/timedatectl.1) 

## Partitioning
[Partitioning](https://wiki.archlinux.org/index.php/partitioning)

#### Find your drive
```
fdisk -l
```
[fdisk(8)](https://man.archlinux.org/man/fdisk.8)

#### Wipe the disk
```
shred --verbose --random-smource=/dev/urandom --iterations=1 /dev/<yourharddrive>
```
[shred(1)](https://man.archlinux.org/man/shred.1)

#### Partition the disk
```
cfdisk /dev/<yourharddrive>
```

[fdisk(8)](https://man.archlinux.org/man/fdisk.8), [cfdisk(8)](https://man.archlinux.org/man/fdisk.8)

* Partition table: GPT
* New → Partition Size: 512 MiB → EFI System
* New → Partition Size: xxxG → Linux Filesystem

#### Format the partitions
```
mkfs.fat -F32 /dev/<efipartition>
mkfs.ext4 /dev/<rootpartition>
```
[File systems](https://wiki.archlinux.org/index.php/file_systems), [mke2fs(8)](https://man.archlinux.org/man/mke2fs.8)

#### Mount the file systems
```
mount /dev/<rootpartition> /mnt
mkdir /mnt/boot
mount /dev/<efipartition> /mnt/boot
```

[mount(8)](https://man.archlinux.org/man/mount.8)

## Installation

#### Run the install script and install some additional packages
```
pacstrap /mnt base base-devel linux linux-firmware systemd-networkd systemd-resolvd nfs-utils nano vi
```
[Kernel](https://wiki.archlinux.org/index.php/Kernel), [pacstrap(8)](https://man.archlinux.org/man/pacstrap.8), [base](https://archlinux.org/packages/core/any/base/), [base-devel](https://archlinux.org/groups/x86_64/base-devel/), [linux](https://archlinux.org/packages/core/x86_64/linux/), [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/)

## Configure the system

#### Generate fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
```
[fstab](https://wiki.archlinux.org/index.php/fstab), [genfstab(8)](https://man.archlinux.org/man/genfstab.8) , [fstab(5)](https://man.archlinux.org/man/fstab.5)

#### chroot
```
arch-chroot /mnt
```
[chroot](https://wiki.archlinux.org/index.php/Chroot), [arch-chroot(8)](https://man.archlinux.org/man/arch-chroot.8)

#### Time zone & hardware clock
In my case, Europe/Stockholm
```
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc --utc
```
[System time](https://wiki.archlinux.org/index.php/System_time), [hwclock(8)](https://man.archlinux.org/man/hwclock.8), [ln(1)](https://man.archlinux.org/man/ln.1)

#### Generate localizations

Edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8`
```
locale-gen
localectl set-locale LANG=en_US.UTF-8
```
[Locale](https://wiki.archlinux.org/index.php/Locale), [localectl(1)](https://man.archlinux.org/man/localectl.1)
#### Set keyboard layout
```
localectl set-keymap --no-convert sv-latin1
```
[Locale](https://wiki.archlinux.org/index.php/Locale), [localectl(1)](https://man.archlinux.org/man/localectl.1)

#### Set computer hostname
```
hostnamectl set-hostname <hostname>
```
[hostnamectl(1)](https://man.archlinux.org/man/hostnamectl.1)

#### Local hostname resolution
Edit `/etc/hosts`. After 127.0.1.1 you should set your local domain and hostname accordingly. If the system has a static IP address, it should be used instead of 127.0.1.1.
```
127.0.0.1 localhost
::1 localhost
127.0.1.1 <hostname>.local <hostname>
```
[hosts(5)](https://man.archlinux.org/man/hosts.5)

#### Configure network
```
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
```
[Network managers](https://wiki.archlinux.org/index.php/Network_configuration#Network_managers), [systemd-networkd](https://wiki.archlinux.org/index.php/systemd-networkd), [systemd-resolvd](https://wiki.archlinux.org/index.php/Systemd-resolved)

#### Set root password 
```
passwd <password>
```
[passwd(1)](https://man.archlinux.org/man/passwd.1)

#### Bootloader
```
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub
```
[GRUB](https://wiki.archlinux.org/index.php/GRUB), [UEFI](https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface), [grub-install(8)](https://man.archlinux.org/man/core/grub/grub-install.8), [efibootmgr](https://wiki.archlinux.org/index.php/EFISTUB#efibootmgr)

#### Microcode
Install Intel or AMD microcode
```
pacman -S <intel-ucode or amd-ucode>
```
[Microcode](https://wiki.archlinux.org/index.php/Microcode)

#### Generate a configuration file for GRUB
```
grub-mkconfig -o /boot/grub/grub.cfg
```
[grub-mkconfig(8)](https://man.archlinux.org/man/grub-mkconfig.8)

#### Exit chroot
```
exit
```

Reboot
```
reboot
```

## Post Installation

#### Add a new user
These commands will add a new user, set a password for it and add it to the admin group wheel.
```
useradd -D -U -G wheel -m <username>
passwd <username>
```
[Users and groups](https://wiki.archlinux.org/index.php/users_and_groups), [useradd(8)](https://man.archlinux.org/man/useradd.8), [passwd(1)](https://man.archlinux.org/man/passwd.1)

## SSH
#### Install OpenSSH and enable the service
```
pacman -S openssh
systemctl enable sshd.service
systemctl start sshd.service
```
[OpenSSH](https://wiki.archlinux.org/index.php/OpenSSH)

#### Hardening
Edit your SSH server config `/etc/ssh/sshd_config` and disable password login. Using Public Key Authentication instead of password authentication is strongly recommended.
```
PasswordAuthentication no
```

Installing a automatic security tool like [CrowdSec](https://crowdsec.net) or [fail2ban](https://wiki.archlinux.org/index.php/Fail2ban) is strongly recommended if SSH will be accessible from the internet.