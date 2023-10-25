# Install liquidsoap on OpenSUSE

## Prerequisites

### Installation

#### Tumbleweed and > Leap 15.5

```sh
sudo zypper install curl opam ocaml make gcc gcc-c++ git autoconf automake libtool pkg-config bzip2
```

#### OpenSUSE Leap 15.5 Only

```sh
sudo zypper install curl ocaml make gcc gcc-c++ git autoconf automake libtool pkg-config bzip2 patch unzip bubblewrap
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
```

### Add Packman repo

```sh
sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/' packman
```

### Initialize opam environment

```sh
opam switch create 4.14.1
eval $(opam env --switch=4.14.1)
opam switch set 4.14.1
```

### Install build dependancies

```sh
sudo zypper install \
ffmpeg-4 ffmpeg-4-libavdevice-devel ffmpeg-4-libavformat-devel ffmpeg-4-libavfilter-devel ffmpeg-4-libavcodec-devel ffmpeg-4-libavutil-devel libcurl-devel pcre-devel fdk-aac-devel libshine-devel flac-devel gmp-devel libogg-devel libvorbis-devel libopus-devel speex-devel libtag-devel libsamplerate-devel
```

## Build

```sh
opam install --no-depexts ffmpeg.1.1.8

opam install \
liquidsoap tls-liquidsoap ffmpeg fdkaac flac shine ogg vorbis opus speex taglib samplerate
```

**Extra optional dependancies:**

* alsa
* ao
* bjack
* camlimages
* ctypes-foreign
* dssi
* faad
* frei0r
* gd (gd-devel Fedora package doesn't satisfy the requirement)
* graphics
* gstreamer (Build error)
* imagelib
* inotify
* irc-client-unix
* jemalloc
* ladspa
* lame
* lastfm
* lilv (liblilv-0-devel OpenSUSE package doesn't satisfy the requirement)
* lo
* mad
* magic
* mem_usage
* memtrace
* osc-unix
* portaudio
* posix-time2
* prometheus-liquidsoap
* pulseaudio
* sdl-liquidsoap
* soundtouch
* srt
* ssl
* theora
* xmlplaylist
* yaml
