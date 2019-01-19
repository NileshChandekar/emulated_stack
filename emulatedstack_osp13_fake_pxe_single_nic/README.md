# Emulated-Stack_Fake_PXE_Single_NIC-Deployment

## Task
  *   Design your Topology
  *   Router Configuration
  *   Switch Configuration
  *   Undercloud Configuration
    * Hostname Setting

    * Register the node

    * User creation - stack

    * Directories creation - images/templates

    * Install ``python-tripleoclient`` package

    * Create ``undercloud.conf``

    * Install Undercloud ``openstack undercloud install``
  *   Overcloud Configuration

# Topology
![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/emulatedstack_osp13_fake_pxe_single_nic/images/q1.png)

## High Level Overview of Interface Placement.

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/emulatedstack_osp13_fake_pxe_single_nic/images/q4.png)
# Router

* Interface Configuration :-

~~~
set interfaces ethernet eth0 address 'dhcp'
set interfaces ethernet eth0 description 'OUTSIDE'
set interfaces ethernet eth1 address '192.168.100.1/24'
set interfaces ethernet eth1 description 'INSIDE'
~~~

* SSH Configure:

~~~
set service ssh port '22'
~~~

* Ethernet Speed Configuration

~~~
set interfaces ethernet eth1 duplex 'auto'
~~~

* Configure Source NAT for our "Inside" network.

~~~
set nat source rule 10 outbound-interface 'eth0'
set nat source rule 10 protocol 'all'
set nat source rule 10 source address '192.168.100.0/24'
set nat source rule 10 translation address 'masquerade'
~~~

* DNS forwarder:

~~~
set service dns forwarding cache-size '0'
set service dns forwarding listen-on 'eth1'
set service dns forwarding name-server '192.168.100.1'
set service dns forwarding name-server '8.8.8.8'
~~~

# Switch

* Activate Interface

~~~
net add interface swp1-12
~~~

* Adding Bridge to make switch port communicate

~~~
net add bridge bridge port swp1-12
net add bridge bridge pvid 1
~~~

# Undercloud

### Setting hostname

~~~
hostnamectl set-hostname undercloud.example.com
hostnamectl set-hostname --transient undercloud.example.com
~~~
~~~
[root@undercloud ~]# cat  /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 undercloud.example.com undercloud
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
[root@undercloud ~]#
~~~

### Registering the Nodes

![Image](https://github.com/NileshChandekar/emulated_stack/blob/master/emulatedstack_without_OVS_LACP/images/e10.png)

### User creation - stack

~~~
useradd stack
echo a | passwd stack  --stdin
echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
chmod 0440 /etc/sudoers.d/stack
~~~

### Directories creation - images/templates

~~~
mkdir ~/images
mkdir ~/templates
~~~

### Install ``python-tripleoclient`` package

~~~
sudo yum install -y python-tripleoclient
~~~

### Create ``undercloud.conf``

~~~
cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf
~~~

~~~
cat undercloud.conf
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
undercloud_ntp_servers clock.redhat.com
~~~

### Install Undercloud ``openstack undercloud install``

~~~
openstack undercloud install
~~~



# Overcloud

# Testing
