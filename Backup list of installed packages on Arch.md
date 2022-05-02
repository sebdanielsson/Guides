# Backup list of installed packages on Arch

Man page: [pacman(8)](https://archlinux.org/pacman/pacman.8.html)

You can generate a list of all installed packages with pacman. You can choose to only list packages that are not themselves dependencies of other installed packages to keep the list short, or generate a complete list of every installed package including dependencies.

## List installed packages

### All packages

``` sh
pacman -Qq
```

### Explicitly installed

``` sh
pacman -Qqe
```

### Explicitly installed and native

``` sh
pacman -Qqen
```

### Explicitly installed and non-native

``` sh
pacman -Qqem
```

## Save installed packages to file

A good backup strategy is to keep a list of installed packages in a file on another system. In case you need to set up a new system you can just install all packages again from this file.

### Native packages

* Explicitly installed
* Only from Arch repos

``` sh
pacman -Qqen > pkglist-native.txt
```

### Non-native packages

* Explicitly installed
* Only from AUR or non-native sources

``` sh
pacman -Qqem > pkglist-non-native.txt
```

## Automate backups with a pacman hook

You can automate this backup process by setting up a pacman hook.
Create a hook at `/usr/share/libalpm/hooks/backup-installed-packages.hook` and edit it.

``` toml
[Trigger]
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
When = PostTransaction
Exec = /bin/sh -c '/usr/bin/pacman -Qqen > /etc/pkglist.txt'
```

Now the hook will make sure the list is up-to-date every time you install or uninstall packages with pacman.

---------

## Not done

## Install packages from a list

If you're on a completely fresh system and would like to install packages from a previously backed up list you just run:

``` sh
pacman -S --needed - < pkglist-native.txt
```

This will installed all packages from the list that aren't already installed.

## Source

[ArchWiki - Pacman - Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)