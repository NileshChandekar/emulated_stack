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
vlan 100 
name provisioning
end
wr
~~~


~~~
SW#sh vlan
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
100  provisioning                     active    
1002 fddi-default                     act/unsup 
1003 token-ring-default               act/unsup 
1004 fddinet-default                  act/unsup 
1005 trnet-default                    act/unsup 

VLAN Type  SAID       MTU   Parent RingNo BridgeNo Stp  BrdgMode Trans1 Trans2
---- ----- ---------- ----- ------ ------ -------- ---- -------- ------ ------
1    enet  100001     1500  -      -      -        -    -        0      0   
10   enet  100010     1500  -      -      -        -    -        0      0   
20   enet  100020     1500  -      -      -        -    -        0      0   
          
VLAN Type  SAID       MTU   Parent RingNo BridgeNo Stp  BrdgMode Trans1 Trans2
---- ----- ---------- ----- ------ ------ -------- ---- -------- ------ ------
30   enet  100030     1500  -      -      -        -    -        0      0   
40   enet  100040     1500  -      -      -        -    -        0      0   
50   enet  100050     1500  -      -      -        -    -        0      0   
100  enet  100100     1500  -      -      -        -    -        0      0   
1002 fddi  101002     1500  -      -      -        -    -        0      0   
1003 tr    101003     1500  -      -      -        -    -        0      0   
1004 fdnet 101004     1500  -      -      -        ieee -        0      0   
1005 trnet 101005     1500  -      -      -        ibm  -        0      0   

Remote SPAN VLANs
------------------------------------------------------------------------------


Primary Secondary Type              Ports
------- --------- ----------------- ------------------------------------------

SW#
~~~

~~~
SW#sh vlan brief 
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
100  provisioning                     active    
1002 fddi-default                     act/unsup 
1003 token-ring-default               act/unsup 
1004 fddinet-default                  act/unsup 
1005 trnet-default                    act/unsup 
SW#
~~~

# ACCESS VLAN IP - configuration 

~~~
configure terminal 
interface vlan 100
ip address 192.168.24.250 255.255.255.0
end
wr
~~~

# ACCESS VLAN INTERFACE - configuration

~~~
conf  t
interface range Ethernet 0/1 - 3
switchport mode access 
switchport access vlan 100
end
wr
~~~
