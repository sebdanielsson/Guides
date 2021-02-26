# Arch Misc

## Mosh

Install Mosh
pacman -S mosh
Mosh - ArchWiki

## Automatically mount external drive

Get the UUID of the partition to mount
lsblk -f
fstab 

Edit etcfstab
UUID=<UUIDOFDRIVE> /mnt/<mountname> auto nofail,x-systemd.device-timeout=30 0 2
lsblk(8)

The nofail option is best combined with the x-systemd.device-timeout option. This is because the default device timeout is 90 seconds, so a disconnected external device with only nofail will make your boot take 90 seconds longer, unless you reconfigure the timeout as shown. Make sure not to set the timeout to 0, as this translates to infinite timeout.

## NFS

Install NFS and enable the service
pacman -S nfs-utils
systemctl enable nfs-server
systemctl start nfs-server
NFS

Configure your shares in etcexports
/mnt/<mountname> *(ro,sync,fsid=0)
NFS Configuration

Chance ro (read-only) to rw (readwrite) for readwrite permissions.

## Transmission

Transmission Web on a Raspberry Pi with Arch Linux - Raymii.org
Home · transmission/transmission Wiki · GitHub
Editing Configuration Files · transmission/transmission Wiki · GitHub

Install Transmission Daemon with CLI and Web Interface 
pacman -S transmission-cli

Run Transmission once as user transmission to create a configuration file
systemctl start transmission.service
systemctl stop transmission.service

Edit the configuration file
nano /var/lib/transmission/.config/transmission-daemon/settings.json

Recommended changes
”encryption”: 1,
”dht-enabled”: false,
”lpd-enabled”: false,
”pex-enabled”: false,
”port-forwarding-enabled”: false,
”rpc-username”: ”<webuiusername>”,
”rpc-password”: ”<webuipassword>”,
”rpc-url”: ”/transmission/”,
”rpc-whitelist”: ”127.0.0.1,192.168.*.*”,
”umask”: 2,
”utp-enabled”: false
octal to umask Calculator, octal to base 10 converter
In my config I set ”umask”: 2, (base 10) which is the same as umask 002 and octal 775. IMPORTRANT: The last line in settings.json shall not end with a comma!

If you want a kill switch, enter your local VPN IP in this line
”bind-address-ipv4”: ”*.*.*.*”,

To be able to change theme of the web UI, change the default web root to a public directory that other users can access
nano /lib/systemd/system/multi-user.target.wants/transmission.service
Note: On Debian bases system this path may be:
”nano etcsystemdsystemmulti-user.target.wants/transmission-daemon.service"

Add this environmental variable
[Service]
Environment=TRANSMISSION_WEB_HOME=/usr/share/transmission

Reload services
systemctl daemon-reload

Check that everything is working as intended and then enable autostart
systemctl start transmission.service
systemctl enable transmission.service

## WireGuard

Installation

pacman -S wireguard-tools wireguard-arch

Configure your first profile

nano /etc/wireguard/wg0.conf

Example for routing most traffic except local through the VPN
[Interface]
PrivateKey = <PRIVATEKEY>
Address = <LOCALIPV4>,<LOCALIPV6>
DNS = <VPNDNS>
PostUp = ip route add 192.168.1.0/24 via 192.168.1.1; ip route add 10.9.0.0/24 via 192.168.1.1;  ip route add 2001:9b1:4054:ef00::0/64 via 2001:9b1:4054:ef00::1;

PreDown = ip route delete 192.168.1.0/24; ip route delete 10.9.0.0/24; ip route delete 2001:9b1:4054:ef00::0/64;

[Peer]
PublicKey = <PUBLICKEY>
AllowedIPs = 0.0.0.0/0,::0/0
Endpoint = <PUBLICVPNSERVERIP>:<PORT>
PersistentKeepalive = 25
This assumes your local subnet is on 192.168.1.0/24 and the router is on 192.168.1.1. IPV6 row is not confirmed working yet (2019-11-25).

## Credits

How to exclude local network packets from Wireguard? : WireGuard

## nginx

Installation

pacman -S nginx-mainline
The default page served at http://127.0.0.1 is usrsharenginxhtml/index.html

Disable the default site

rm /etc/nginx/sites-enabled/default

Configure nginx

DigitalOcean has provided a tool for configuring your web server
nginxconfig.io
nano /etc/nginx/nginx.conf

To avoid “Could not build optimal types_hash” error, make sure these values are set
types_hash_max_size 4096;
server_names_hash_bucket_size 128;

Make your Let’s Encrypt certificates renew automatically

Make a Certbot service
Certbot - ArchWiki
nano /etc/systemd/system/certbot.service

[Unit]
Description=Let’s Encrypt renewal

[Service]
Type=oneshot
ExecStart=/usr/bin/certbot renew —quiet —agree-tos —deploy-hook “systemctl reload nginx.service”

Make it run twice a day at random times
/etc/systemd/system/certbot.timer

[Unit]
Description=Twice daily renewal of Let’s Encrypt’s certificates

[Timer]
OnCalendar=0/12:00:00
RandomizedDelaySec=1h
Persistent=true

[Install]
WantedBy=timers.target

Ghost blog platform with NGINX reverse proxy 

Install required packages

pacman -S nodejs-lts-erbium npm sqlite

Install Ghost-CLI

npm install ghost-cli@latest -g

Create a folder to install Ghost to and go to it

mkdir /var/www/<yourdomain.com>
cd /var/www/<yourdomain.com>

Install Ghost with a sqlite database

ghost install —db sqlite3
When asking about URL, type the full URL.
Example: https://hogwarts.zone

Disable the default site

rm /etc/nginx/sites-enabled/default

Configure your first site

DigitalOcean has provided a tool for configuring your web server
nginxconfig.io

Try this config and only change only your domain name and then follow the installation instructions
NGINX Config | DigitalOcean

Avoiding “Could not build optimal types_hash” error

To avoid “Could not build optimal types_hash” error, make sure these values are set
nano /etc/nginx/nginx.conf

types_hash_max_size 4096;
server_names_hash_bucket_size 128;

Make your Let’s Encrypt certificates renew automatically

Make a Certbot service
Certbot - ArchWiki
nano /etc/systemd/system/certbot.service

[Unit]
Description=Let’s Encrypt renewal

[Service]
Type=oneshot
ExecStart=/usr/bin/certbot renew —quiet —agree-tos —deploy-hook “systemctl reload nginx.service”

Make it run twice a day at random times
/etc/systemd/system/certbot.timer

[Unit]
Description=Twice daily renewal of Let’s Encrypt’s certificates

[Timer]
OnCalendar=0/12:00:00
RandomizedDelaySec=1h
Persistent=true

[Install]
WantedBy=timers.target

Edit the config

nano /etc/nginx/sites-available/<yourdomain.com>.conf

server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;

        server_name hogwarts.zone;
        root /var/www/ghost;

        # SSL
        ssl_certificate /etc/letsencrypt/live/hogwarts.zone/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/hogwarts.zone/privkey.pem;
        ssl_trusted_certificate /etc/letsencrypt/live/hogwarts.zone/chain.pem;

        # security
        #include nginxconfig.io/security.conf;

        # additional config
        #include nginxconfig.io/general.conf;

        location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_pass http://127.0.0.1:2368;
        }

        location ~ /.well-known {
        allow all;
        }

        client_max_body_size 50m;
}

# HTTP redirect
server {
        listen 80;
        listen [::]:80;

        server_name hogwarts.zone;

        #include nginxconfig.io/letsencrypt.conf;

        location / {
        return 301 https://hogwarts.zone$request_uri;
        }
}
Change hogwarts.zone to your own domain name

Activate your site in NGINX

cd /etc/nginx
ln -s sites-available/<yourdomain.com> sites-enabled/<yourdomain.com>

Run NGINX

systemctl start nginx
systemctl enable nginx

Live

Your website should now be live att https:<yourdomain.com>


Let’s Encrypt Certbot SSL on Nginx

User Guide — Certbot 0.25.0.dev0 documentation
https://www.ssllabs.com/ssltest/
Getting a Perfect SSL Labs Score - Michael Lustfield