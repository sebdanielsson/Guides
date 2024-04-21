# Cisco IOS ACLs

To create a numbered standard ACL, use the following global configuration command:

`access-list access-list-number {deny | permit | remark text} source [source-wildcard] [log]`

Use the no access-list access-list-number global configuration command to remove a numbered standard ACL.

The table provides a detailed explanation of the syntax for a standard ACL.

| Parameter | Description |
| --- | --- |
| access-list-number | Specifies the number of the standard ACL. The range is from 1 to 99 or 1300 to 1999. |
| deny | Denies packets that match the criteria specified in the ACL. |
| permit | Permits packets that match the criteria specified in the ACL. |
| remark text | Adds a comment to the ACL. |
| source | Specifies the source IP address or network. |
| source-wildcard | Specifies the wildcard mask for the source IP address or network. |
| log | Logs a message when a packet matches the criteria specified in the ACL. |

To create a named standard ACL, use the following global configuration command:

`ip access-list standard acl-name`

To remove a named standard ACL, use the following global configuration command:

`no ip access-list standard acl-name`

Example:

```sh
ip access-list standard ACL-EXAMPLE
```

To add a permit or deny statement to a named standard ACL, use the following configuration command:

`permit source [source-wildcard] [log]`

`deny source [source-wildcard] [log]`

To add a remark to a named standard ACL, use the following configuration command:

`remark text`

Example:

```sh
deny host 192.168.10.10

permit 10.0.0.0 0.255.255.255

remark This is an example ACL.
```

## Secure the VTY Lines

To secure the VTY lines, use the following global configuration command:

`access-class access-list-number {in | out} [vrf-also]`

R1(config)# username ADMIN secret class
R1(config)# ip access-list standard ADMIN-HOST
R1(config-std-nacl)# remark This ACL secures incoming vty lines
R1(config-std-nacl)# permit 192.168.10.10
R1(config-std-nacl)# deny any
R1(config-std-nacl)# exit
R1(config)# line vty 0 4
R1(config-line)# login local
R1(config-line)# transport input telnet
R1(config-line)# access-class ADMIN-HOST in
R1(config-line)# end
R1#

To secure the VTY lines, use the following global configuration command:

`access-class access-list-number {in | out} [vrf-also]`

Example:

```sh
username ADMIN secret class
ip access-list standard ADMIN-HOST
remark This ACL secures incoming vty lines
permit 192.168.10.10
deny any
exit
line vty 0 4
login local
transport input telnet
access-class ADMIN-HOST in
end
```

In a production environment, it is recommended to use SSH instead of Telnet for remote access. To configure SSH, use the following global configuration commands:

```sh
line vty 0 4
login local
transport input ssh
access-class ADMIN-HOST in
end
```
