# Build EasySSH from source on FreeBSD

## Install dependencies (FreeBSD)

```sh
pkg install devel/git devel/meson devel/cmake devel/pkgconf devel/libgee devel/json-glib devel/gettext devel/desktop-file-utils devel/appstream-glib lang/vala lang/python3 security/gnupg x11-toolkits/gtk30 x11-toolkits/granite devel/libvterm x11-toolkits/vte3
```

## Install dependencies (Fedora)

```sh
dnf install git meson cmake pkgconf libgee-devel json-glib-devel gettext desktop-file-utils libappstream-glib vala python3 gnupg2 gtk3-devel granite-devel vte291-devel
```

## Clone the git repo

```sh
git clone https://github.com/sebdanielsson/easyssh.git
cd easyssh
```

## Build

```sh
meson setup build --prefix=/usr
cd build
ninja test
```

## Install

```sh
sudo ninja install
com.github.muriloventuroso.easyssh
```
