# Cisco IOS Cheatsheet

## Command Modes

| Mode      | Description                                 | Access       | Prompt | Exit |
| --------- | ------------------------------------------- | ------------ | ------ | ---------- |
| User EXEC | Allows access to basic monitoring commands. | First level. | >      | **logout** |
| Privileged EXEC | Privileged mode that allows access to all commands.  | From user EXEC: **enable** | # | **disable** = user EXEC |

## Configuration Modes

| Configuration Mode | Description                                         | Access       | Prompt    | Exit       |
| ---------------- | --------------------------------------------------- | ------------ | --------- | ---------- |
| Global config    | Used to configure the device as a whole.            | From privileged EXEC: **configure** *terminal* | (config)# | **exit, end** = privileged EXEC |
| Line config      | Used to configure authentication for console, SSH, Telnet and AUX access.       | From global config: **line** *console 0* | (config-line)# | **exit** = global config<br>**end** = privileged EXEC |
| Interface config | Used to configure a switch port or router network interface. | From global config: **interface** *interface-id* | (config-if)#) | **exit** = global config<br>***end*** = privileged EXEC |
| Config-vlan      | Used to configure VLAN parameters.                  | From global config: **vlan** *vlan-id*  | (config-vlan)# | **exit** = global config<br>**end** = privileged EXEC |

## General Device Configuration

| Description              | Command |
| ------------------------ | ------- |
| Execute privileged command from other config mode | **do** *command* |
| Disable DNS lookup       | **no ip domain-lookup** |
| Set hostname             | **hostname** *name* |
| Configure the IP domain name | **ip domain name** example.local |
| Set time and date with NTP<br> Get a NTP server IP by pinging time.cloudflare.com | **ntp server ip** *time.cloudflare.com* **ntp server** *ip-address* |
| Set time and date manually (Not recommended) | **clock set** *HH:MM:SS 1 January 1970* |
| Configure single interface | **interface** *g0/0* |
| Configure interface range | **interface range** *g0/0 - 5* |
| Configure single line interface | **line console 0**<br>**line vty** *0* |
| Configure line interface range | **line vty** *0 15* |
| Save config | **copy** *running-config startup-config* |
| Restore previous config  | **copy** *startup-config running-config* |
| Restore factory default config | **erase** *startup-config*<br>**reload** |

## Router Configuration

| Description              | Command |
| ------------------------ | ------- |
| Enable IPV6 routing | **ipv6 unicast-routing** |
| Configure interface | **ip address** *192.168.1.1 255.255.255.0*<br>**ipv6 address** *2001:db8:acad:1::1/64*<br>**ipv6 address** *fe80::1 link-local*<br>**description** *#LAN connection to server room#*<br>**no shutdown** |
| Add gateway of last resort | **ip route 0.0.0.0 0.0.0.0** *upstream-router* |

## Switch Configuration

| Description              | Command |
| ------------------------ | ------- |
| Enable IPv6 address capabilities | **sdm prefer** *dual-ipv4-and-ipv6 default* |
| Set default IPv6 route | **ipv6 route** *::/0* *gateway* |

## Remote Access & Security

Note: To configure SSH you first need to configure a device hostname and domain name.

| Description              | Command |
| ------------------------ | ------- |
| Legal MOTD               | **banner motd** *#Authorized Access Only#* |
| Encrypt all passwords    | **service password-encryption** |
| Min password length      | **security passwords min-length** *12* |
| Rate limit vty login attempts | **login block-for** *300* **attempts** *3* **within** *60* |
| Secure privileged access | **enable secret** *password* |
| Secure console access    | **password** *password*<br>**login** |
| Configure SSH | **ip ssh rsa keypair-name** *sshkey*<br>**crypto key generate rsa usage-keys label** *sshkey* **modulus** *2048*<br>**username** *user* **secret** *password*<br>**ip ssh time-out** *120*<br>**ip ssh authentication-retries** *3*<br>**ip ssh version** *2* |
| Secure vty access        | **exec-timeout** *2*<br>**login local**<br>**transport input ssh** |
| Configure SVI for remote access | **ip default-gateway** *gateway-ip*<br>**interface vlan 1**<br>**ip address** *switch-ip subnet-mask*<br>**ipv6 address** *switch-ipv6/64*<br>**no shutdown**<br>**description** *your description*<br>**exit** |

## Help & Troubleshooting

| Description              | Command |
| ------------------------ | ------- |
| List commands            | **?** |
| List debug commands      | **debug ?** |
| Show available info commands | **show ?** |
| Show running config      | **show running-config** |
| Show interface status    | **show interfaces** |
| Show IP interface status | **show ip interface** |
| Show ARP table           | **show arp** |
| Show routing information | **show ip route** |
| Show protocol status     | **show protocols** |
| Show memory, interfaces, and licences of the device | **show version** |

## Useful Network Tools

[Wireshark - OUI Lookup Tool](https://www.wireshark.org/tools/oui-lookup.html)