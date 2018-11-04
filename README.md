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


