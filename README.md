# Design/Planning

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e5.png)

# Interface Configuration 

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e3.png)

									

# Switch 

~~~
SW#sh ip int br
~~~

~~~
Interface              IP-Address      OK? Method Status                Protocol
Ethernet0/0            unassigned      YES unset  up                    up      
Ethernet0/1            unassigned      YES unset  up                    up      
Ethernet0/2            unassigned      YES unset  up                    up      
Ethernet0/3            unassigned      YES unset  up                    up      
Ethernet1/0            unassigned      YES unset  up                    up      
Ethernet1/1            unassigned      YES unset  up                    up      
Ethernet1/2            unassigned      YES unset  up                    up      
Ethernet1/3            unassigned      YES unset  up                    up      
Ethernet2/0            unassigned      YES unset  up                    up      
Ethernet2/1            unassigned      YES unset  up                    up      
Ethernet2/2            unassigned      YES unset  up                    up      
Ethernet2/3            unassigned      YES unset  up                    up      
Ethernet3/0            unassigned      YES unset  up                    up      
Ethernet3/1            unassigned      YES unset  up                    up      
Ethernet3/2            unassigned      YES unset  up                    up      
Ethernet3/3            unassigned      YES unset  up                    up      
Vlan1                  unassigned      YES unset  administratively down down    
SW#
~~~

# vlan database

~~~
conf t
vlan 10  
name ExternalNetworkVlanID
vlan 20  
name StorageNetworkVlanID
vlan 30  
name InternalApiNetworkVlanID
vlan 40  
name StorageMgmtNetworkVlanID
vlan 50  
name TenantNetworkVlanID
end
wr
~~~


~~~
IOU1#sh vlan
~~~

~~~
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Et0/0, Et0/1, Et0/2, Et0/3
                                                Et1/0, Et1/1, Et1/2, Et1/3
                                                Et2/0, Et2/1, Et2/2, Et2/3
                                                Et3/0, Et3/1, Et3/2, Et3/3
10   ExternalNetworkVlanID            active    
20   StorageNetworkVlanID             active    
30   InternalApiNetworkVlanID         active    
40   StorageMgmtNetworkVlanID         active    
50   TenantNetworkVlanID              active    
1002 fddi-default                     act/unsup 
1003 token-ring-default               act/unsup 
1004 fddinet-default                  act/unsup 
1005 trnet-default                    act/unsup 

VLAN Type  SAID       MTU   Parent RingNo BridgeNo Stp  BrdgMode Trans1 Trans2
---- ----- ---------- ----- ------ ------ -------- ---- -------- ------ ------
1    enet  100001     1500  -      -      -        -    -        0      0   
10   enet  100010     1500  -      -      -        -    -        0      0   
20   enet  100020     1500  -      -      -        -    -        0      0   
30   enet  100030     1500  -      -      -        -    -        0      0   
40   enet  100040     1500  -      -      -        -    -        0      0   
50   enet  100050     1500  -      -      -        -    -        0      0   
1002 fddi  101002     1500  -      -      -        -    -        0      0   
1003 tr    101003     1500  -      -      -        -    -        0      0   
1004 fdnet 101004     1500  -      -      -        ieee -        0      0   
1005 trnet 101005     1500  -      -      -        ibm  -        0      0   
          
Remote SPAN VLANs
------------------------------------------------------------------------------
          

Primary Secondary Type              Ports
------- --------- ----------------- ------------------------------------------

IOU1#
~~~



~~~
IOU1#sh vlan br
~~~

~~~
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Et0/0, Et0/1, Et0/2, Et0/3
                                                Et1/0, Et1/1, Et1/2, Et1/3
                                                Et2/0, Et2/1, Et2/2, Et2/3
                                                Et3/0, Et3/1, Et3/2, Et3/3
10   ExternalNetworkVlanID            active    
20   StorageNetworkVlanID             active    
30   InternalApiNetworkVlanID         active    
40   StorageMgmtNetworkVlanID         active    
50   TenantNetworkVlanID              active    
1002 fddi-default                     act/unsup 
1003 token-ring-default               act/unsup 
1004 fddinet-default                  act/unsup 
1005 trnet-default                    act/unsup 
IOU1#
~~~


### VTP CONFIGURATION ### 

~~~
conf t
vtp mode server 
vtp domain OPENSTACKLAB
end
wr
~~~

### TRUNK PORT CONFIGURATION FOR VLAN RANGE 10-50 ###


~~~
configure terminal 
interface range Ethernet 3/0 - 3
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 1-4,10-50,1002-1005
end
wr
~~~


### STP CONFIGURATION
~~~
conf t
interface range Ethernet 3/0 - 3
switchport mode trunk
spanning-tree portfast
end
wr
~~~

### Check Trunk Details 

~~~
ESW1# sh interfaces trunk 
~~~

~~~
Port        Mode             Encapsulation  Status        Native vlan
Et3/0       on               802.1q         trunking      1
Et3/1       on               802.1q         trunking      1
Et3/2       on               802.1q         trunking      1
Et3/3       on               802.1q         trunking      1

Port        Vlans allowed on trunk
Et3/0       1-4,10-50,1002-1005
Et3/1       1-4,10-50,1002-1005
Et3/2       1-4,10-50,1002-1005
Et3/3       1-4,10-50,1002-1005

Port        Vlans allowed and active in management domain
Et3/0       1,10,20,30,40,50
Et3/1       1,10,20,30,40,50
Et3/2       1,10,20,30,40,50
Et3/3       1,10,20,30,40,50

Port        Vlans in spanning tree forwarding state and not pruned
Et3/0       1,10,20,30,40,50
Et3/1       1,10,20,30,40,50
Et3/2       1,10,20,30,40,50
Et3/3       1,10,20,30,40,50
IOU1#
~~~


# Switch EtherChannel Configuration 

### Channel Group 1 for port 3/0 - 1

~~~
conf t
interface range Ethernet 3/0 - 1
channel-group 1 mode active
end
wr
~~~

### Channel Group 1 for port 3/2 - 3

~~~
conf t
interface range Ethernet 3/2 - 3
channel-group 2 mode active
end
wr
~~~

# Server Side Configuration 

### Setting hostname // Undercloud 
~~~
# hostnamectl set-hostname undercloud.example.com
# hostnamectl set-hostname --transient undercloud.example.com
~~~

~~~
[root@undercloud ~]# hostname -f 
undercloud.example.com
[root@undercloud ~]# 
~~~


### Setting hostname // Controller 

~~~
# hostnamectl set-hostname ctrl.example.com
# hostnamectl set-hostname --transient ctrl.example.com
~~~

~~~
[root@ctrl ~]# hostname -f 
ctrl.example.com
[root@ctrl ~]# 
~~~


### Setting hostname // Compute 

~~~
# hostnamectl set-hostname cmpt.example.com
# hostnamectl set-hostname --transient cmpt.example.com
~~~

~~~
[root@cmpt ~]# hostname -f 
cmpt.example.com
[root@cmpt ~]# 
~~~

### Add hostentry for Undercloud node `` etc/hosts ``  // Undercloud Node

~~~
[root@undercloud ~]# cat  /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 undercloud.example.com undercloud
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
[root@undercloud ~]# 
~~~


### IP details , // Undercloud 
~~~
[root@undercloud ~]# ip a
~~~

~~~
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:90:80:54 brd ff:ff:ff:ff:ff:ff
    inet 192.168.24.1/24 brd 192.168.24.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe90:8054/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:16:78:f4 brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.10/24 brd 10.10.10.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe16:78f4/64 scope link 
       valid_lft forever preferred_lft forever
[root@undercloud ~]# 
~~~


### IP details , // Controller Node  

~~~
[root@ctrl ~]# ip a
~~~

~~~
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:eb:8a:b0 brd ff:ff:ff:ff:ff:ff
    inet 192.168.24.2/24 brd 192.168.24.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feeb:8ab0/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:73:77:2f brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.20/24 brd 10.10.10.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe73:772f/64 scope link 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:cc:00:0a brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:15:53:c3 brd ff:ff:ff:ff:ff:ff
[root@ctrl ~]# 
~~~


### IP details , // Compute Node 

~~~
[root@cmpt ~]# ip a
~~~

~~~
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:12:24:35 brd ff:ff:ff:ff:ff:ff
    inet 192.168.24.3/24 brd 192.168.24.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe12:2435/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:93:14:17 brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.30/24 brd 10.10.10.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe93:1417/64 scope link 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:25:90:86 brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:2a:fa:e8 brd ff:ff:ff:ff:ff:ff
[root@cmpt ~]# 
~~~


### Create stack user 

~~~
useradd stack
echo a | passwd stack  --stdin
echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
chmod 0440 /etc/sudoers.d/stack
~~~

### Creating Directories for Templates and Images

~~~
[stack@undercloud ~]$ mkdir ~/images
[stack@undercloud ~]$ mkdir ~/templates
~~~

### Registering your System


### Installing the Director Packages

~~~
[stack@undercloud ~]$ sudo yum install -y python-tripleoclient
~~~

### Configuring the Director

~~~
$ cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf
~~~


~~~
[DEFAULT]
local_interface = eth0
local_ip = 192.168.24.1/24
network_gateway = 192.168.24.250
undercloud_public_vip = 192.168.24.2
undercloud_admin_vip = 192.168.24.3
network_cidr = 192.168.24.0/24
masquerade_network = 192.168.24.0/24
dhcp_start = 192.168.24.5
dhcp_end = 192.168.24.24
inspection_iprange = 192.168.24.100,192.168.24.120
~~~


~~~
$ openstack undercloud install
~~~


### Check the enabled services using the following command: 

~~~
$ sudo systemctl list-units openstack-*
~~~

### To initialize the stack user to use the command line tools, run the following command: 

~~~
$ source ~/stackrc
~~~

### Creating a User for Configuring Nodes, :- Once you have created and configured the stack user on all pre-provisioned nodes, copy the stack user’s public SSH key from the director node to each overcloud node. For example, to copy the director’s public SSH key to the Controller node:

~~~
$ ssh-copy-id stack@192.168.24.2
~~~


Installing the User Agent on Nodes

~~~
# sudo yum -y install python-heat-agent*
~~~

~~~
Configuring Networking for the Control Plane
~~~


~~~
ctlplane-assignments.yaml
~~~

~~~
resource_registry:
  OS::TripleO::DeployedServer::ControlPlanePort: /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-neutron-port.yaml

parameter_defaults:
  DeployedServerPortMap:
    controller-ctlplane:
      fixed_ips:
        - ip_address: 192.168.24.2
      subnets:
        - cidr: 24
    compute-ctlplane:
      fixed_ips:
        - ip_address: 192.168.24.3
      subnets:
        - cidr: 24
~~~
