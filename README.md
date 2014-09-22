# Getting started with RozoFS and Vagrant

This Vagrant file describes the deployment of four virtual machines on which
is set a full installation of [RozoFS](http://www.rozofs.org) to play with.


## Presentation

### RozoFS - distributed file system

[RozoFS](http://www.rozofs.org) is an I/O centric distributed file system
that deals with data reliability. It is meant to protect data and services
upon failures. This protection is done by the Mojette erasure code. RozoFS is
based on three components:

* *exportd*: the metadata manager;

* *storaged*: the data store;

* *rozofsmount*: this program relies on [FUSE](fuse.sourceforge.net/) to mount
the file system.

### Vagrant - deploy virtual environments

[Vagrant](http://www.vagrantup.com/) is an open source software to "create and
configure lightweight, reproducible and portable development environments".
It relies on *boxes* (available at [VagrantCloud](https://vagrantcloud.com/))
that can be shared and used by anyone who wants to launch the same virtual
environment, based on industry-standard technology.
Essentially, given a small document in Ruby called a *Vagrantfile* that
describes the configuration of a set of VMs, Vagrant will download, configure
and run these VMs in VirtualBox or other software.

## What does it do ?

### Deploy RozoFS over 4 VMs

The Vagrantfile here describes how the 4 VMs - based on an
[Ubuntu](http://www.ubuntu.com/) 14.04 box that contains the software
RozoFS - are deployed.
Two types of nodes are deployed: one MetaData Server (MDS) that runs exportd,
storaged and rozofsmount (optional), and three Mojette Projection Storage
Servers (MPSS) which run storaged and rozofsmount (optional).

Here is the architecture of the virtual environment:

```
+-------------------------------------------------------------------------------+
| +---------------+   +---------------+   +---------------+   +---------------+ |
| |      MDS      |   |     MPSS1     |   |     MPSS2     |   |     MPSS3     | |
| |               |   |               |   |               |   |               | |
| |  exportd      |   |               |   |               |   |               | |
| |  storaged     |   |  storaged     |   |  storaged     |   |  storaged     | |
| |  rozofsmount  |   |  rozofsmount  |   |  rozofsmount  |   |  rozofsmount  | |
| +---------------+   +---------------+   +---------------+   +---------------+ |
|  192.168.100.10      192.168.100.11      192.168.100.12      192.168.100.13   |
+-------------------------------------------------------------------------------+
```

## Setup

### Requirements 

The followings are needed:
* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)

### Using

The deployment has been tested with Vagrant 1.6.3, VirtualBox 4.3.14, on
Ubuntu 13.10 (Linux 3.11). It is very simple:

```shell
$ git clone http://github.com/denaitre/rozofsbox_multi
$ cd rozofsbox_multi
$ vagrant up
$ # ???            this part might take a long time...
$ # profit !
```
Tadaaaam!

## Play with it

### Check the state of RozoFS

RozoFS is mounted on each VM you can access by ssh. For example:

```shell
$ vagrant ssh mds
vagrant@mds:~$ df
Filesystem     1K-blocks     Used Available Use% Mounted on
/dev/sda1       41251136  1287080  38228144   4% /
none                   4        0         4   0% /sys/fs/cgroup
udev              249996       12    249984   1% /dev
tmpfs              50724      376     50348   1% /run
none                5120        4      5116   1% /run/lock
none              253612        0    253612   0% /run/shm
none              102400        0    102400   0% /run/user
vagrant         67154552 62232620   4921932  93% /vagrant
rozofs         106570960        0 106570960   0% /mnt/rozofs@192.168.100.10/export_1
```

If RozoFS is installed on your host machine, it is also possible to mount
the file system on your host machine :) Please check before that the versions
of RozoFS are the same on your machine and on your VMs.

```shell
$ rozo --version
$ (sudo) mkdir /mnt/rozofs/
$ (sudo) rozofsmount /mnt/rozofs/ -H 192.168.100.10 -E /srv/rozofs/exports/export_1
```
