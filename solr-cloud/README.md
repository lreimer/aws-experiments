# Apache Solr Cloud with Terraform

Creates a Solr Cloud in AWS with a custom AMI in the default VPC, distributed over 3 AZs using Route53 DNS for node discovery.

You need an SSH keypair to run this module:
```bash
$ ssh-keygen -t rsa -b 2048 -f solrcloud
```

Currently there is some initial setup to be performed once the infrastructure has been created.

```bash
$ terraform output
$ ssh ec2-user@<<IP_ADDRESS>> -i solrcloud

$ echo "ZK_HOST=\"zookeeper-0.zookeeper.cloud,zookeeper-1.zookeeper.cloud,zookeeper-2.zookeeper.cloud/solr\"" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh
$ echo "SOLR_HEAP=\"512m\"" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh
$ echo "SOLR_HOST=\"solr-0.solr.cloud\"" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh

$ sudo su solr
$ cd /home/solr/solr-8.6.0
$ bin/solr zk mkroot /solr -z zookeeper-0.zookeeper.cloud

$ bin/solr start -c
```
