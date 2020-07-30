# Apache Zookeeper Ensemble with Terraform

Creates a Zookeeper ensemble in AWS with a custom AMI in the default VPC, distributed over 3 AZs using Route53 DNS for node discovery.

You need an SSH keypair to run this module:
```bash
$ ssh-keygen -t rsa -b 2048 -f zookeeper
```

Sometimes the Zookeeper process does not start properly. If so, login to each machine
via SSH and start manually.

```bash
$ terraform output
$ ssh ec2-user@<<IP_ADDRESS>> -i zookeeper
$ sudo runuser -u zookeeper -- /home/zookeeper/apache-zookeeper-3.6.1/bin/zkServer.sh start
```