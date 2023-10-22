# Get IP address from interface

```sh
TAILSCALE0_GLOBAL_IPV4=$(ip -f inet addr show tailscale0 scope global | grep "inet " | awk '{print $2}')
TAILSCALE0_GLOBAL_IPV6=$(ip -f inet -6 addr show tailscale0 scope global | grep "inet6 " | awk '{print $2}')
```
