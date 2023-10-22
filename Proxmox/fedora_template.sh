# Fedora Cloud Base 37 1.7 - wget https://download.fedoraproject.org/pub/fedora/linux/releases/37/Cloud/x86_64/images/Fedora-Cloud-Base-37-1.7.x86_64.qcow2
# Set script variables
IMAGE_FILE='Fedora-Cloud-Base-37-1.7.x86_64.qcow2'
TEMPLATE_ID='1000'
TEMPLATE_NAME='fedora-template'
STORAGE='local-lvm'

# Create VM (--ostype can be l26 for Linux kernel 2.6 or newer or win11 for Windows 11)
qm create $TEMPLATE_ID --name $TEMPLATE_NAME --machine q35 --cpu cputype=host --core 2 --memory 2048 --net0 virtio,bridge=vmbr0 --bios ovmf --ostype l26

# Import image
qm importdisk $TEMPLATE_ID $IMAGE_FILE $STORAGE

# Add EFI disk
qm set $TEMPLATE_ID -efidisk0 $STORAGE:0,format=raw,efitype=4m,pre-enrolled-keys=1

# Add TPM Module (Windows 11)
#qm set $TEMPLATE_ID -tpmstate0 $STORAGE:1,version=v2.0

# Attach image as storage device
qm set $TEMPLATE_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$TEMPLATE_ID-disk-1

# Attach a drive for cloud-init
qm set $TEMPLATE_ID --ide2 $STORAGE:cloudinit

# Configure VM to boot from our image
qm set $TEMPLATE_ID --boot c --bootdisk scsi0

# Add a serial console
qm set $TEMPLATE_ID --serial0 socket --vga serial0

# Convert VM to template
qm template $TEMPLATE_ID
