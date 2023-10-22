# Cockpit only listen to Tailscale connections

```systemd title='/etc/systemd/system/cockpit.socket.d/listen.conf'
[Socket]
ListenStream=
ListenStream=192.168.0.1:9090
ListenStream=[2001:0db8:85a3:0000:0000:8a2e:0370:7334]:9090
FreeBind=yes
```

## Source

[https://cockpit-project.org/guide/latest/listen](https://cockpit-project.org/guide/latest/listen)
