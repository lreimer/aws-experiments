# Elasticsearch Cluster with Terraform

Creates an Elasticsearch Cluster in AWS with a custom AMI in the default VPC, distributed over 3 AZs.

You need an SSH keypair to run this module:
```bash
$ ssh-keygen -t rsa -b 2048 -f elastic
```

Currently, you have to manually start the Elasticsearch cluster after the EC2 nodes have been provisioned.
For automatic startup, have a look at https://www.elastic.co/guide/en/elasticsearch/reference/7.9/starting-elasticsearch.html

```bash
# do the following for all 3 nodes
$ ssh ec2-user@`terraform output elastic-0` -i elastic
$ cd elasticsearch-7.9.2
$ bin/elasticsearch

$ ssh ec2-user@`terraform output elastic-1` -i elastic
$ cd elasticsearch-7.9.2
$ bin/elasticsearch

$ ssh ec2-user@`terraform output elastic-2` -i elastic
$ cd elasticsearch-7.9.2
$ bin/elasticsearch

# then query the REST API
$ http get `terraform output elastic-0`:9200/_nodes
```
