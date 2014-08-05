## Get started with RozoFS using Vagrant

This a Vagrant file to set a single node on which is installed RozoFS.

### RozoFS

RozoFS is an I/O centric distributed file system that deals with data
reliability. It is meant to protect data and services upon failures. This
protection is done by the Mojette erasure code. RozoFS is based on three
applications:

* exportd: the metadata manager;

* storaged: the data store;

* rozofsmount: this program relies on FUSE to mount the file system.

Of course, the three components should be distributed to different nodes in
order to face node failures. However, it is possible to get started with
RozoFS installing the previous three on a single node.

### Vagrant

Vagrant is an open source software to share virtual machine environments. It
provides *boxes* that can be shared by anyone who wants to launched the same
environment.

Here, we want to set a *vagrantfile* to set a ready for action VM to learn and
try RozoFS.
