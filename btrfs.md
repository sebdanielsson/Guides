https://www.maketecheasier.com/the-beginners-guide-to-btrfs/


[sebastian@odroid-n2 ~]$ sudo fdisk -l
Disk /dev/mmcblk1: 116.48 GiB, 125069950976 bytes, 244277248 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x54abe20e

Device         Boot  Start       End   Sectors   Size Id Type
/dev/mmcblk1p1       62500    500000    437501 213.6M  c W95 FAT32 (LBA)
                                                  Disk: /dev/sda
                             Size: 1.82 TiB, 2000398934016 bytes, 3907029168 sectors
                           Label: gpt, identifier: 39C00134-4BC8-44DD-A95E-6CA5BE667610

    Device                      Start                End            Sectors          Size Type
>>  /dev/sda1                    2048         3907029134         3907027087          1.8T Linux filesystem













 ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 │  Partition UUID: 8120A7AA-8712-E24C-B5A3-54C349E68063                                                        │
 │  Partition type: Linux filesystem (0FC63DAF-8483-4772-8E79-3D69D8477DE4)                                     │
 │ Filesystem UUID: 27a8978f-4ab0-4f20-81e3-531c5d2c3713                                                        │
 │Filesystem LABEL: lacie                                                                                       │
 │      Filesystem: btrfs                                                                                       │
 └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
                [ Delete ]  [ Resize ]  [  Quit  ]  [  Type  ]  [  Help  ]  [  Write ]  [  Dump  ]


                                           Delete the current partition
                                                  Disk: /dev/sda
                             Size: 1.82 TiB, 2000398934016 bytes, 3907029168 sectors
                           Label: gpt, identifier: 39C00134-4BC8-44DD-A95E-6CA5BE667610

    Device                       Start                 End             Sectors           Size Type
>>  Free space                    2048          3907029134          3907027087           1.8T















 ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 │ Filesystem UUID: 27a8978f-4ab0-4f20-81e3-531c5d2c3713                                                        │
 │Filesystem LABEL: lacie                                                                                       │
 │      Filesystem: btrfs                                                                                       │
 └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘



                              Type "yes" or "no", or press ESC to leave this dialog.
/dev/mmcblk1p2      500001 244277247 243777247 116.2G 83 Linux


Disk /dev/zram0: 5.41 GiB, 5806911488 bytes, 1417703 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/sda: 1.82 TiB, 2000398934016 bytes, 3907029168 sectors
Disk model: P9227 Slim
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 39C00134-4BC8-44DD-A95E-6CA5BE667610

Device     Start        End    Sectors  Size Type
/dev/sda1   2048 3907029134 3907027087  1.8T Linux filesystem
[sebastian@odroid-n2 ~]$ ls /mnt
total 8
drwxr-xr-x  2 root 4096 Feb  7 16:51 .
drwxr-xr-x 19 root 4096 Mar  7 23:18 ..
[sebastian@odroid-n2 ~]$ sudo mkdir /mnt/btrfs
[sudo] password for sebastian:
[sebastian@odroid-n2 ~]$ sudo mount -t btrfs /dev/sda /mnt/btrfs
mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/sda, missing codepage or helper program, or other error.
[sebastian@odroid-n2 ~]$ sudo cfdisk /dev/sda

Syncing disks.
[sebastian@odroid-n2 ~]$ sudo mkfs.btrfs -L lacie /dev/sda
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

/dev/sda appears to contain a partition table (gpt).
ERROR: use the -f option to force overwrite of /dev/sda
[sebastian@odroid-n2 ~]$ sudo mkfs.btrfs -F -L lacie /dev/sda
mkfs.btrfs: invalid option -- 'F'
Usage: mkfs.btrfs [options] dev [ dev ... ]
Options:
  allocation profiles:
	-d|--data PROFILE           data profile, raid0, raid1, raid1c3, raid1c4, raid5, raid6, raid10, dup or single
	-m|--metadata PROFILE       metadata profile, values like for data profile
	-M|--mixed                  mix metadata and data together
  features:
	--csum TYPE
	--checksum TYPE             checksum algorithm to use (default: crc32c)
	-n|--nodesize SIZE          size of btree nodes
	-s|--sectorsize SIZE        data block size (may not be mountable by current kernel)
	-O|--features LIST          comma separated list of filesystem features (use '-O list-all' to list features)
	-R|--runtime-features LIST  comma separated list of runtime features (use '-R list-all' to list runtime features)
	-L|--label LABEL            set the filesystem label
	-U|--uuid UUID              specify the filesystem UUID (must be unique)
  creation:
	-b|--byte-count SIZE        set filesystem size to SIZE (on the first device)
	-r|--rootdir DIR            copy files from DIR to the image root directory
	--shrink                    (with --rootdir) shrink the filled filesystem to minimal size
	-K|--nodiscard              do not perform whole device TRIM
	-f|--force                  force overwrite of existing filesystem
  general:
	-q|--quiet                  no messages except errors
	-V|--version                print the mkfs.btrfs version and exit
	--help                      print this help and exit
  deprecated:
	-l|--leafsize SIZE          deprecated, alias for nodesize
[sebastian@odroid-n2 ~]$ sudo mkfs.btrfs -f -L lacie /dev/sda
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

Label:              lacie
UUID:               1aa210fa-9563-49f6-8333-b94adab7f8e5
Node size:          16384
Sector size:        4096
Filesystem size:    1.82TiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Runtime features:
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1     1.82TiB  /dev/sda

[sebastian@odroid-n2 ~]$ sudo mount -t btrfs /dev/sda /mnt/btrfs
[sebastian@odroid-n2 ~]$ ls /mnt
total 24
drwxr-xr-x  3 root 4096 Mar  8 16:32 .
drwxr-xr-x 19 root 4096 Mar  7 23:18 ..
drwxr-xr-x  1 root    0 Mar  8 16:35 btrfs
[sebastian@odroid-n2 ~]$ ls /mnt/btrfs
total 20
drwxr-xr-x 1 root    0 Mar  8 16:35 .
drwxr-xr-x 3 root 4096 Mar  8 16:32 ..
[sebastian@odroid-n2 ~]$ sudo btrfs subvolume create /mnt/btrfs/media
Create subvolume '/mnt/btrfs/media'
[sebastian@odroid-n2 ~]$