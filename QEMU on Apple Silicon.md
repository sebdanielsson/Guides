# Install QEMU on Apple Silicon Macs

## Prerequisites
Install [Xcode](https://apps.apple.com/se/app/xcode/id497799835)

Install [MacPorts](https://www.macports.org/install.php)

Install build dependencies
```
sudo port install autoconf automake gettext glib2 libffi libpixman libtool ninja pkgconfig texinfo
```

## Build QEMU
Clone the project
```
git clone https://git.qemu.org/git/qemu.git
cd qemu
git checkout 56a11a9b7580b576a9db930667be07f1dd1564d5
```

Apply Alexander Graf's patches
```
curl -L https://patchwork.kernel.org/series/418581/mbox | git am
```

Build QEMU
```
mkdir build
cd build
../configure --target-list=aarch64-softmmu --enable-hvf --disable-gnutls
make -j8
```
Comment: Without --disable-gnutls, make will crash. This will hopefully be resolved shortly.


## Install
Install QEMU
```
sudo make install
```

Resign the QEMU binary
```
sudo codesign --entitlements /path/to/qemu/accel/hvf/entitlements.plist --force -s - \`which qemu-system-aarch64\`
```
Comment: For some reason the QEMU binary is modified during the installation. Resign it with the correct entitlements to avoid error messages.


## Configure the VM
Create a directory to store the VM files
```
mkdir -p ~/VM/Ubuntu
cd ~/VM/Ubuntu
```

Create a virtual drive
```
qemu-img create -f qcow2 vda.qcow2 20G
```

Create a file for storing UEFI variables
```
dd if=/dev/zero conv=sync bs=1m count=64 of=ovmf_vars.fd
```

Download the OS
```
curl https://cdimage.ubuntu.com/releases/20.10/release/ubuntu-20.10-live-server-arm64.iso
```

Create a launch script
```
nano launch.sh
```

```
qemu-system-aarch64 \
    -machine virt,highmem=off,accel=hvf \
    -cpu max -smp 4 \
    -m 4G \
    -device virtio-net-pci,netdev=net0 \
    -device virtio-blk-pci,drive=drv0 \
    -usb -device usb-ehci -device usb-kbd -device usb-mouse \
    -vga none -device ramfb \
    -monitor stdio \
    -netdev user,id=net0 \
    -drive file=/usr/local/share/qemu/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
    -drive file=ovmf_vars.fd,if=pflash,format=raw \
    -drive file=vda.qcow2,if=none,format=qcow2,id=drv0 \
    -cdrom ubuntu-20.04.2-live-server-arm64.iso
```

Make script executable
```
chmod +x launch.sh
```

## Installation
Start the VM and boot the installer
```
./launch.sh
```