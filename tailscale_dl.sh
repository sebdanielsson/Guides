#!/bin/sh
TS_ARCH=mipsle # amd64, arm64, riscv64 also available
TS_LATEST=$(curl --silent https://api.github.com/repos/tailscale/tailscale/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v\(.*\)/\1/')
curl https://pkgs.tailscale.com/stable/tailscale_"$TS_LATEST"_"$TS_ARCH".tgz | tar -xzvf -
mv tailscale_"$TS_LATEST"_"$TS_ARCH"/tailscale /usr/sbin/tailscale
mv tailscale_"$TS_LATEST"_"$TS_ARCH"/tailscaled /usr/sbin/tailscaled
rm -Rf tailscale_"$TS_LATEST"_"$TS_ARCH"
