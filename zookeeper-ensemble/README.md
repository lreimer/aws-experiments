# Apache Zookeeper Ensemble with Terraform

Creates a Zookeeper ensemble in AWS with a custom AMI in a dedicated VPC, distributed over 3 AZs using Route53 DNS for node discovery.

You need an SSH keypair to run this module:
```bash
$ ssh-keygen -t rsa -b 2048 -f zookeeper
```