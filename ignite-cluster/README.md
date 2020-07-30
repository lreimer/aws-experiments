# Apache Ignite Cluster with Terraform

Creates an Ignite Cluster in AWS with a custom AMI in the default VPC, distributed over 3 AZs using Zookeeper for node discovery.

You need an SSH keypair to run this module:
```bash
$ ssh-keygen -t rsa -b 2048 -f ignite
```

Currently there is some initial setup to be performed once the infrastructure has been created.

```bash
$ terraform output
$ ssh ec2-user@<<IP_ADDRESS>> -i ignite

$ sudo su ignite
$ cd /home/ignite/apache-ignite-2.8.1
$ bin/ignite.sh config/ignite-zookeeper.xml
```
