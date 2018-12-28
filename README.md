# Design/Planning

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e1.png)

## Tools used to build Pre-Prvisioned Emulated Stack

	* EVE-NG - Emulated Virtual Environemnt.
	* Vyos - Router
	* Cumulus - Switch
	* rhel7.5 - Servers


### What is EVE

	* The Emulated Virtual Environment for Network, Security and DevOps professionals
	* EVE-NG is graphical network emulators that support both commercial and open-source router images.
	* For more details [Click Here](http://eve-ng.net/)

### What is Vyos

	* VyOS provides a free routing platform that competes directly with other commercially available solutions from well known network providers.
	* Because VyOS is run on standard amd64, i586 and ARM systems, it is able to be used as a router and firewall platform for cloud deployments
	* For more details [Click Here](https://vyos.io/)


### What is Cumulus-VX

	* Cumulus Linux is an open networking Linux operating system for bare metal switches.
	* It is based on Debian

### What is rhel7

	* Red Hat Enterprise Linux is a Linux distribution developed by Red Hat and targeted toward the commercial market.
	* Red Hat Enterprise Linux is released in server versions for x86-64, Power Architecture, ARM64, and IBM Z, and a desktop version for x86-64


# Vyos - Roouter Configuration

#### Interface Configuration

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e2.png)

####  Configure Source NAT for our "Inside" network.

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e3.png)

#### DNS forwarder:

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e4.png)


# Cumulus-VX - Switch Configuration

#### Activate Interfaces

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e5.png)

#### Adding Bridge to make switch port communicate

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e8.png)


#### Trunked Vlan Configuration

![Image ](/https://github.com/NileshChandekar/emulated_stack/blob/master/images/e9.png)




# RHEL-7.5 Installtion

#### Download `` qcow2 `` and import to EVE-NG.


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
# hostnamectl set-hostname overcloud-controller-0.localdomain
# hostnamectl set-hostname --transient overcloud-controller-0.localdomain
~~~

~~~
[root@ctrl ~]# hostname -f
overcloud-controller-0.localdomain
[root@ctrl ~]#
~~~


### Setting hostname // Compute

~~~
# hostnamectl set-hostname overcloud-compute-0.localdomain
# hostnamectl set-hostname --transient overcloud-compute-0.localdomain
~~~

~~~
[root@cmpt ~]# hostname -f
overcloud-compute-0.localdomain
[root@cmpt ~]#
~~~

### Add hostentry for Undercloud node `` /etc/hosts ``  // Undercloud Node

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

# On Undercloud Node

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

![Image ](https://github.com/NileshChandekar/emulated_stack/blob/master/images/e10.png)


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

#### Creating a User for Configuring Nodes, :- Once you have created and configured the stack user on all pre-provisioned nodes, copy the stack user’s public SSH key from the director node to each overcloud node. For example, to copy the director’s public SSH key to the Controller node:

~~~
$ ssh-copy-id stack@192.168.24.2
~~~

~~~
$ ssh-copy-id stack@192.168.24.3
~~~

# Controller Node

#### Installing the User Agent on Nodes

~~~
# sudo yum -y install python-heat-agent*
~~~


#### Configuring Networking for the Control Plane

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
