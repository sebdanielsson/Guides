# OSPF Configuration Guide

## Interface Configuration Verification

List the interfaces and their OSPF configurations:

```sh
show ip protocols
```

## Show OSPF interface configuration

List the OSPF interface configuration. This command shows the OSPF process ID, the router ID, and the area ID for each interface. `show ip ospf interface {{interface-name}}`

```sh
show ip ospf interface GigabitEthernet 0/0/0
```

## Show OSPF neighbor information

List the OSPF neighbors and their status. `show ip ospf neighbor`

```sh
show ip ospf neighbor
```

## Show OSPF database

List the OSPF database. This command shows the OSPF link-state advertisements (LSAs) and their types. `show ip ospf database`

```sh
show ip ospf database
```

## Show OSPF route information

List the OSPF routing table. This command shows the OSPF routes and their next hops. `show ip route ospf`

```sh
show ip route ospf
```

## Show OSPF topology information

List the OSPF topology table. This command shows the OSPF routes and their associated LSAs. `show ip ospf topology`

```sh
show ip ospf topology
```

## Show OSPF summary information

List the OSPF summary information. This command shows the OSPF process ID, the router ID, and the area ID. `show ip ospf summary`

```sh
show ip ospf summary
```

## Show OSPF virtual link information

List the OSPF virtual link information. This command shows the OSPF virtual link status and configuration. `show ip ospf virtual-links`

```sh
show ip ospf virtual-links
```

## Enter OSPF Configuration Mode

Enter the OSPF router configuration mode and specify a process ID. The process ID is a number from 1 to 65535 that identifies the OSPF process on the router. It is locally significant only. `router ospf {{process-id}}`

Example:

Process ID: `10`

```sh
router ospf 10
```

## Configure Router ID

Configure router ID. The router ID is a 32-bit number that uniquely identifies the router in the OSPF domain. It is used to identify the source of OSPF routing information. `router-id {{router-id}}`

Example:

Router ID: `2.2.2.2`

```sh
router-id 2.2.2.2
```

## Advertise Networks

Advertise the networks connected to the router using the `network` command, along with the appropriate wildcard mask and area ID. The wildcard mask is the inverse of the subnet mask. For example, the wildcard mask for a subnet mask of 192.168.1.0/24 would be 0.0.0.255. `network {{network-id}} {{wildcard-mask}} area {{area-id}}`

Example:

1. Network `10.10.2.0/24` (255.255.255.0) in area `0`
2. Network `10.1.1.4/30` (255.255.255.252) in area `0`

```sh
network 10.10.2.0 0.0.0.255 area 0
network 10.1.1.4 0.0.0.3 area 0
```

## Enable OSPF on Interfaces

Enable OSPF on specific interfaces using their IP addresses and a quad-zero wildcard mask in area 0. `network {{interface-ip}} 0.0.0.0 area 0`

Example:

1. Interface IP `10.10.3.1`
2. Interface IP `10.1.1.10`

```sh
network 10.10.3.1 0.0.0.0 area 0
network 10.1.1.10 0.0.0.0 area 0
```

## Configure OSPF on Specific Interfaces

Enable OSPF on specific interfaces directly using the `ìnterface {{interface-name}}` and `ip ospf process-id area area-id` commands:

Example:

1. Interface `GigabitEthernet 0/0/0` in area `0` and process ID `10`

```sh
interface GigabitEthernet 0/0/0
ip ospf 10 area 0
```

## Configure Passive Interfaces

Make all interfaces passive by default.

```sh
passive-interface default
```

Set specific interface as passive. `passive-interface {{interface-name}}`

Example:

1. Interface `GigabitEthernet 0/0/0`

```sh
passive-interface GigabitEthernet 0/0/0
```

Remove an interface from the passive list. `no passive-interface {{interface-name}}`

```sh
no passive-interface GigabitEthernet 0/0/0
```

## Point-to-Point Network

Configure a point-to-point network. This disables the DR/BDR election process. `interface {{interface-name}}` and `ip ospf network point-to-point`

Example:

1. Interface `GigabitEthernet 0/0/0`

```sh
interface GigabitEthernet 0/0/0
ip ospf network point-to-point
```

## Multi-Access Network

Configure a multi-access network. This enables the DR/BDR election process. `interface {{interface-name}}` and `ip ospf network broadcast`

Example:

1. Interface `GigabitEthernet 0/0/0`

```sh
interface GigabitEthernet 0/0/0
ip ospf network broadcast
```

## Configure OSPF Priority

Set the OSPF priority for the DR/BDR election. `interface {{interface-name}}` `ip ospf priority {{priority}}`

Example:

1. Interface `GigabitEthernet 0/0/0` with priority `255`

```sh
interface GigabitEthernet 0/0/0
ip ospf priority 255
```

## Clear OSPF Process

Clear the OSPF process. This command resets the OSPF process and re-establishes adjacencies. `clear ip ospf process`

```sh
clear ip ospf process
```

## Automatically configure cost on an interface

Set the OSPF cost for an interface. `interface {{interface-name}}` `auto-cost reference-bandwidth {{bandwidth-in-megabits-per-second}}`

Example:

1. Interface `GigabitEthernet 0/0/0` with bandwidth `10000`

```sh
interface GigabitEthernet 0/0/0
auto-cost reference-bandwidth 10000
```

## Manually configure cost on an interface

Set the OSPF cost for an interface. `interface {{interface-name}}` `ip ospf cost {{cost}}`

Example:

1. Interface `GigabitEthernet 0/0/0` with cost `100`

```sh
interface GigabitEthernet 0/0/0
ip ospf cost 100
```

## Show cost to reach a network

List the cost to reach a network. The cost is the `metric`. This command shows the OSPF cost to reach a specific network. `show ip route | include {{network}}`

Example:

1. Network: `10.10.2.0`
2. Network: `192.168.1.0`

```sh
show ip route | include 10.10.2.0
show ip route | include 192.168.1.0
```

## Test failover

Test the OSPF failover. `interface {{interface-name}}` `shutdown`

Example:

1. Interface `GigabitEthernet 0/0/0`

```sh
interface GigabitEthernet 0/0/0
shutdown
```

## Modify OSPF hello and dead intervals

Modify the OSPF hello and dead intervals. `interface {{interface-name}}` `ip ospf hello-interval {{seconds}}` and `ip ospf dead-interval {{seconds}}`

Example:

1. Interface `GigabitEthernet 0/0/0` with hello interval `10` and dead interval `40`

```sh
interface GigabitEthernet 0/0/0
ip ospf hello-interval 10
ip ospf dead-interval 40
```

## Restore OSPF hello and dead intervals to default

Restore the OSPF hello and dead intervals to default. `interface {{interface-name}}` `no ip ospf hello-interval` and `no ip ospf dead-interval`

Example:

1. Interface `GigabitEthernet 0/0/0`

```sh
interface GigabitEthernet 0/0/0
no ip ospf hello-interval
no ip ospf dead-interval
```
