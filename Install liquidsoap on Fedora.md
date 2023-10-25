# Install liquidsoap on Fedora

## Prerequisites

### Installation

```sh
sudo dnf install opam ocaml make gcc git
```

### Initialize opam environment

```sh
opam switch create 4.14.1
eval $(opam env --switch=4.14.1)
opam switch set 4.14.1
```

### Add rpmfusion repo

```sh
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

### Install build dependencies

```sh
sudo dnf install --allowerasing alsa-lib-devel dssi-devel faad2-devel fdk-aac-free-devel ffmpeg-devel file-devel flac-devel frei0r-devel gcc-c++ gmp-devel jack-audio-connection-kit-devel jemalloc-devel ladspa-devel lame-devel libao-devel libcurl-devel liblo-devel libmad-devel libogg-devel libsamplerate-devel libtheora-devel libvorbis-devel lilv-devel opus-devel pcre-devel portaudio-devel pulseaudio-libs-devel SDL2-devel SDL2_image-devel SDL2_ttf-devel soundtouch-devel speex-devel srt-devel taglib-devel
```

## Install liquidsoap

**Missing optional dependencies:**

- gd (gd-devel Fedora package doesn't satisfy the requirement)
- gstreamer (Build error)
- shine (Fedora package not found)
- ssl (Unnecessary)

### Install liquidsoap with extra dependencies

```sh
opam install liquidsoap alsa ao bjack camlimages ctypes-foreign dssi faad fdkaac ffmpeg flac frei0r graphics imagelib inotify irc-client-unix jemalloc ladspa lame lastfm lilv lo mad magic memtrace mem_usage ogg opus osc-unix portaudio posix-time2 pulseaudio prometheus-liquidsoap samplerate sdl-liquidsoap soundtouch speex srt taglib tls-liquidsoap theora vorbis yaml xmlplaylist
```
